defmodule ReservationParser do
  def valid_line(line) do
    String.starts_with?(line, "SEGMENT") || String.starts_with?(line, "BASED")
  end

  def parse_line(line) do
    words = String.split(line, " ")

    case words do
      ["SEGMENT:", type | details] ->
        parse_segment(type, details)

      ["BASED:", details] ->
        details
    end
  end

  defp build_datetime(date, time) do
    date_iso8601 = "#{date}T#{time}:00Z"
    {:ok, datetime, _} = DateTime.from_iso8601(date_iso8601)
    datetime
  end

  defp build_date(date) do
    {:ok, date} = Date.from_iso8601(date)
    date
  end

  # Pattern matching to parse input file. How cool is that!? :D
  defp parse_segment("Flight", [origin, start_date, start_time, _, destination, end_time]) do
    %TravelSegment{
      type: "Flight",
      origin: origin,
      destination: destination,
      start_date: start_date,
      start_time: start_time,
      end_time: end_time,
      # To simplify datetime comparison for sorting purposes.
      start_datetime: build_datetime(start_date, start_time),
      end_datetime: build_datetime(start_date, end_time)
    }
  end

  defp parse_segment("Train", [origin, start_date, start_time, _, destination, end_time]) do
    %TravelSegment{
      type: "Train",
      origin: origin,
      destination: destination,
      start_date: start_date,
      start_time: start_time,
      end_time: end_time,
      start_datetime: build_datetime(start_date, start_time),
      end_datetime: build_datetime(start_date, end_time)
    }
  end

  defp parse_segment("Hotel", [location, checkin_date, _, checkout_date]) do
    %HotelSegment{
      location: location,
      checkin_date: build_date(checkin_date),
      checkout_date: build_date(checkout_date)
    }
  end
end
