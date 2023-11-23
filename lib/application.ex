defmodule Lib.Application do
  use Application

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

  defmodule Parser do
    def build_datetime(date, time) do
      date_iso8601 = "#{date}T#{time}:00Z"
      {:ok, datetime, _} = DateTime.from_iso8601(date_iso8601)
      datetime
    end

    def build_date(date) do
      {:ok, date} = Date.from_iso8601(date)
      date
    end

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

    defp parse_segment("Flight", [origin, start_date, start_time, _, destination, end_time]) do
      %TravelSegment{
        type: "Flight",
        origin: origin,
        destination: destination,
        start_date: start_date,
        start_time: start_time,
        end_time: end_time,
        start_datetime: build_datetime(start_date, start_time),
        end_datetime: build_datetime(start_date, end_time),
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
        end_datetime: build_datetime(start_date, end_time),
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

  defp is_connection(%TravelSegment{} = segment1, %TravelSegment{} = segment2) do
    same_location = segment1.destination == segment2.origin
    diff = DateTime.diff(segment2.start_datetime, segment1.end_datetime, :hour)
    same_location && diff >= 0 && diff < 24
  end

  defp is_connection(%TravelSegment{} = segment1, %HotelSegment{} = segment2) do
    same_location = segment1.destination == segment2.location
    diff = Date.diff(segment2.checkin_date, DateTime.to_date(segment1.end_datetime))
    same_location && diff >= 0 && diff <= 1
  end

  defp is_connection(%HotelSegment{} = segment1, %TravelSegment{} = segment2) do
    same_location = segment1.location == segment2.origin
    diff = Date.diff(DateTime.to_date(segment2.start_datetime), segment1.checkout_date)
    same_location && diff >= 0 && diff <= 1
  end

  defp is_connection(%HotelSegment{} = segment1, %HotelSegment{} = segment2) do
    same_location = segment1.location == segment2.location
    diff = Date.diff(segment2.checkin_date, segment1.checkout_date)
    same_location && diff >= 0 && diff <= 1
  end

  defp compare(%TravelSegment{} = segment1, %TravelSegment{} = segment2) do
    case DateTime.compare(segment1.start_datetime, segment2.start_datetime) do
      :eq -> case DateTime.compare(segment1.end_datetime, segment2.end_datetime) do
            :lt -> true
            _ -> false
             end
      :lt -> true
      _ -> false
    end
  end

  defp compare(%TravelSegment{} = segment1, %HotelSegment{} = segment2) do
    case Date.compare(DateTime.to_date(segment1.start_datetime), segment2.checkin_date) do
      :eq -> case Date.compare(DateTime.to_date(segment1.end_datetime), segment2.checkout_date) do
        :lt -> true
        _ -> false
         end
      :lt -> true
      _ -> false
    end
  end

  defp compare(%HotelSegment{} = segment1, %TravelSegment{} = segment2) do
    case Date.compare(segment1.checkin_date, DateTime.to_date(segment2.start_datetime)) do
      :eq -> case Date.compare(segment1.checkout_date, DateTime.to_date(segment2.end_datetime)) do
        :lt -> true
        _ -> false
         end
    :lt -> true
    _ -> false
    end
  end

  defp compare(%HotelSegment{} = segment1, %HotelSegment{} = segment2) do
    case Date.compare(segment1.checkin_date, segment2.checkin_date) do
      :eq -> case DateTime.compare(segment1.checkout_date, segment2.checkout_date) do
        :lt -> true
        _ -> false
         end
    :lt -> true
    _ -> false
    end
  end

  def group_elements(list) do
    group_elements(list, [], [])
  end

  defp group_elements([], [], acc) do
    Enum.reverse(acc)
  end

  defp group_elements([], group, acc) do
    Enum.reverse([Enum.reverse(group) | acc])
  end

  defp group_elements([elem | rest], [head | _tail] = group, acc) do
    case is_connection(head, elem) do
      true ->
        group_elements(rest, [elem | group], acc)
      false ->
        group_elements(rest, [elem], [Enum.reverse(group) | acc])
    end
  end

  defp group_elements([elem | rest], [], acc) do
    group_elements(rest, [elem], acc)
  end

  def start(_type, _args) do

    lines = String.split(File.read!("input.txt"), "\r\n", trim: true)
    segments = lines
      |> Enum.filter(&Parser.valid_line/1)
      |> Enum.map(&Parser.parse_line/1)

    [based | segments] = segments

    segment = Enum.sort(segments, &compare/2)

    result = group_elements(segment)
    IO.inspect(result)

    # Print groups with required format

    {:ok, self()}
  end

end
