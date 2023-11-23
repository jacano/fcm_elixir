defmodule TripFormatter do
  def print_segment(segment) do
    case segment do
      %TravelSegment{} ->
        "#{segment.type} from #{segment.origin} to #{segment.destination} at #{segment.start_date} #{segment.start_time} to #{segment.end_time}\n"
      %HotelSegment{} ->
        "Hotel at #{segment.location} on #{segment.checkin_date} to #{segment.checkout_date}\n"
    end
  end

  def print_trip(trip) do
    "TRIP to #{Enum.join(trip, ", ")}\n"
  end
end
