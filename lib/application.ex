defmodule Lib.Application do
  use Application

  def start(_type, _args) do

    reservation = String.split(File.read!("input.txt"), "\r\n", trim: true)
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

    out = Enum.zip_with(t1, t2, fn (a1, a2) -> a1 <> Enum.join(a2, "") <> "\n" end)
    IO.puts(out)

    {:ok, self()}
  end
end
