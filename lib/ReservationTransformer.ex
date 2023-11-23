defmodule ReservationTransformer do

  def transform(input_path) do
    reservation = String.split(File.read!(input_path), "\n", trim: true)
      |> Enum.filter(&ReservationParser.valid_line/1)
      |> Enum.map(&ReservationParser.parse_line/1)

    [based | segments] = reservation

    trips = segments
      |> Enum.sort(&SegmentComparer.compare/2)
      |> SegmentGrouper.group_segments(based)

    trip_summary = trips
      |> Enum.map(fn sublist -> Enum.filter(sublist, &TripGenerator.only_travels_not_based(&1, based)) end)
      |> Enum.map(&TripGenerator.remove_connections/1)
      |> Enum.map(fn sublist -> Enum.map(sublist, &TripGenerator.get_destination/1) end)

    t1 = trip_summary |> Enum.map(&TripFormatter.print_trip/1)
    t2 = trips |> Enum.map(fn sublist -> Enum.map(sublist, &TripFormatter.print_segment/1) end)

    Enum.join(Enum.zip_with(t1, t2, fn (a1, a2) -> a1 <> Enum.join(a2, "") <> "\n" end), "")
  end
end
