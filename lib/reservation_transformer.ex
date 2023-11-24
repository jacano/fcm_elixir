defmodule ReservationTransformer do

  def transform(input_path) do

    #Transform the reservation lines into a segment list. Just BASED and SEGMENT tags will be considered.
    reservation = String.split(File.read!(input_path), "\n", trim: true)
      |> Enum.filter(&ReservationParser.valid_line/1)
      |> Enum.map(&ReservationParser.parse_line/1)

    #Extract based and segments.
    [based | segments] = reservation

    #Sort them by start date(time) and them end date(time).
    #Generate trips considering evaluating whether travel segments are connected to each others and beginning at ´based´.
    trips = segments
      |> Enum.sort(&SegmentComparer.compare/2)
      |> SegmentGrouper.generate_sublists(based)

    #Compute trip summary by removing segments whose destination is ´based´.
    #Remove all travel segments that are travel connections.
    #Map trips to their destination to obtain final trip summary.
    trip_summary = trips
      |> Enum.map(fn sublist -> Enum.filter(sublist, &TripGenerator.only_travels_not_based(&1, based)) end)
      |> Enum.map(&TripGenerator.remove_connections/1)
      |> Enum.map(fn sublist -> Enum.map(sublist, &TripGenerator.get_destination/1) end)

    #Accomodate to required output format.
    t1 = trip_summary |> Enum.map(&TripFormatter.print_trip/1)
    t2 = trips |> Enum.map(fn sublist -> Enum.map(sublist, &TripFormatter.print_segment/1) end)

    #Merge trips ans summary and return result.
    Enum.join(Enum.zip_with(t1, t2, fn (a1, a2) -> a1 <> Enum.join(a2, "") <> "\n" end), "")
  end
end
