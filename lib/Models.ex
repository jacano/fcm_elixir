defmodule TravelSegment do
  defstruct type: nil,
            origin: nil,
            destination: nil,
            start_date: nil,
            start_time: nil,
            end_time: nil,
            start_datetime: nil,
            end_datetime: nil
end

defmodule HotelSegment do
  defstruct location: nil,
            checkin_date: nil,
            checkout_date: nil
end
