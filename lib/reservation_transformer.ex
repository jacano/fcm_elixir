defmodule ReservationTransformer do

  def transform(input_path) do

    #Transform the reservation lines into a reservation list.
    #Just BASED and SEGMENT tags will be considered.
    reservation = String.split(File.read!(input_path), "\n", trim: true)
      |> Enum.filter(&ReservationParser.valid_line/1)
      |> Enum.map(&ReservationParser.parse_line/1)

    #Extract based and segments.
    [based | segments] = reservation

    #Sort them by start (date)time and them end (date)time.
    #Generate trips considering `based` as the starting and optionally end point for trips.
    trips = segments
      |> Enum.sort(&SegmentComparer.compare/2)
      |> SegmentGrouper.group_segments(based)

    #Compute trip summary by removing segments whose destination is ´based´.
    #Removing all travel segments that are connections.
    #Mapping trips to their destination.
    trip_summary = trips
      |> Enum.map(fn sublist -> Enum.filter(sublist, &TripGenerator.only_travels_not_based(&1, based)) end)
      |> Enum.map(&TripGenerator.remove_connections/1)
      |> Enum.map(fn sublist -> Enum.map(sublist, &TripGenerator.get_destination/1) end)

    #Accomodated to required format.
    t1 = trip_summary |> Enum.map(&TripFormatter.print_trip/1)
    t2 = trips |> Enum.map(fn sublist -> Enum.map(sublist, &TripFormatter.print_segment/1) end)

    #Merge and return result.
    Enum.join(Enum.zip_with(t1, t2, fn (a1, a2) -> a1 <> Enum.join(a2, "") <> "\n" end), "")
  end
end
