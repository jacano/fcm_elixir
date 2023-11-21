defmodule Lib.Application do
  use Application

  defmodule TravelSegment do
    defstruct type: nil,
              origin: nil,
              destination: nil,
              start_date: nil,
              start_time: nil,
              end_time: nil,
              start_datetime: nil
  end

  defmodule HotelSegment do
    defstruct location: nil,
              checkin_date: nil,
              checkout_date: nil
  end

  defmodule Parser do

    def valid_line(line) do
      String.starts_with?(line, "SEGMENT") || String.starts_with?(line, "BASED")
    end

    def build_datetime_iso8601(date, time) do
      date_iso8601 = "#{date}T#{time}:00Z"
      {:ok, datetime, _} = DateTime.from_iso8601(date_iso8601)
      datetime
    end

    def build_date_iso8601(date) do
      {:ok, date} = Date.from_iso8601(date)
      date
    end

    def parse_line(line) do
      words = String.split(line, " ")

      case words do
        ["SEGMENT:", type | details] ->
          parse_segment(type, details)
        ["BASED:", details] ->
          parse_based(details)
      end
    end

    defp parse_segment("Flight", [origin, start_date, start_time, _, destination, end_time]) do
      %TravelSegment{
        type: "Flight",
        origin: origin,
        destination: destination,
        start_date: build_date_iso8601(start_date),
        start_time: start_time,
        end_time: end_time,
        start_datetime: build_datetime_iso8601(start_date, start_time),
      }
    end

    defp parse_segment("Train", [origin, start_date, start_time, _, destination, end_time]) do
      %TravelSegment{
        type: "Train",
        origin: origin,
        destination: destination,
        start_date: build_date_iso8601(start_date),
        start_time: start_time,
        end_time: end_time,
        start_datetime: build_datetime_iso8601(start_date, start_time),
      }
    end

    defp parse_segment("Hotel", [location, checkin_date, _, checkout_date]) do
      %HotelSegment{
        location: location,
        checkin_date: build_date_iso8601(checkin_date),
        checkout_date: build_date_iso8601(checkout_date)
      }
    end

    defp parse_based(iata) do
      based = iata
    end
  end

  def start(_type, _args) do

    lines = String.split(File.read!("input.txt"), "\r\n", trim: true)
    segments = lines
      |> Enum.filter(&Parser.valid_line/1)
      |> Enum.map(&Parser.parse_line/1)

    # Sort by start_date (+ start_time), then group by trip starting from BASED
    # Print groups with required format

    IO.inspect(segments)

    {:ok, self()}
  end

end
