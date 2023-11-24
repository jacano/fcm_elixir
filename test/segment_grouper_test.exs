defmodule SegmentGrouperTests do
  use ExUnit.Case

  test "ensure_it_groups" do
    groups =
      SegmentGrouper.generate_sublists(
        [
          %TravelSegment{
            origin: "MAD",
            destination: "BCN"
          },
          %TravelSegment{
            origin: "BCN",
            destination: "TFS"
          },
          %TravelSegment{
            origin: "BCN",
            destination: "TFS"
          },
          %TravelSegment{
            origin: "TFS",
            destination: "GGG"
          }
        ],
        [1]
      )

    expected_groups = [
      [
        %TravelSegment{
          type: nil,
          origin: "MAD",
          destination: "BCN",
          start_date: nil,
          start_time: nil,
          end_time: nil,
          start_datetime: nil,
          end_datetime: nil
        },
        %TravelSegment{
          type: nil,
          origin: "BCN",
          destination: "TFS",
          start_date: nil,
          start_time: nil,
          end_time: nil,
          start_datetime: nil,
          end_datetime: nil
        }
      ],
      [
        %TravelSegment{
          type: nil,
          origin: "BCN",
          destination: "TFS",
          start_date: nil,
          start_time: nil,
          end_time: nil,
          start_datetime: nil,
          end_datetime: nil
        },
        %TravelSegment{
          type: nil,
          origin: "TFS",
          destination: "GGG",
          start_date: nil,
          start_time: nil,
          end_time: nil,
          start_datetime: nil,
          end_datetime: nil
        }
      ]
    ]

    assert groups == expected_groups
  end
end
