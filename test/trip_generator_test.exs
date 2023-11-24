defmodule TripGeneratorTests do
  use ExUnit.Case

  test "ensure_it_removes_connections" do
    expected_segments = [
      %TravelSegment{
        origin: "BCN",
        destination: "SVQ",
        start_datetime: ~U[2023-01-10 12:30:00Z],
        end_datetime: ~U[2023-01-10 17:50:00Z]
      },
      %TravelSegment{
        origin: "SVQ",
        destination: "TFS",
        start_datetime: ~U[2023-04-10 10:30:00Z],
        end_datetime: ~U[2023-04-10 11:50:00Z]
      }
    ]

    segments =
      TripGenerator.remove_connections([
        %TravelSegment{
          origin: "MAD",
          destination: "BCN",
          start_datetime: ~U[2023-01-10 10:30:00Z],
          end_datetime: ~U[2023-01-10 11:50:00Z]
        },
        %TravelSegment{
          origin: "BCN",
          destination: "SVQ",
          start_datetime: ~U[2023-01-10 12:30:00Z],
          end_datetime: ~U[2023-01-10 17:50:00Z]
        },
        %TravelSegment{
          origin: "SVQ",
          destination: "TFS",
          start_datetime: ~U[2023-04-10 10:30:00Z],
          end_datetime: ~U[2023-04-10 11:50:00Z]
        }
      ])

    assert expected_segments == segments
  end
end
