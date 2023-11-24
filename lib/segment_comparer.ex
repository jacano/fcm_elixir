defmodule SegmentComparer do
  def compare(%TravelSegment{} = segment1, %TravelSegment{} = segment2) do
    case DateTime.compare(segment1.start_datetime, segment2.start_datetime) do
      :eq ->
        case DateTime.compare(segment1.end_datetime, segment2.end_datetime) do
          :lt -> true
          _ -> false
        end

      :lt ->
        true

      _ ->
        false
    end
  end

  def compare(%TravelSegment{} = segment1, %HotelSegment{} = segment2) do
    case Date.compare(DateTime.to_date(segment1.start_datetime), segment2.checkin_date) do
      :eq ->
        case Date.compare(DateTime.to_date(segment1.end_datetime), segment2.checkout_date) do
          :lt -> true
          _ -> false
        end

      :lt ->
        true

      _ ->
        false
    end
  end

  def compare(%HotelSegment{} = segment1, %TravelSegment{} = segment2) do
    case Date.compare(segment1.checkin_date, DateTime.to_date(segment2.start_datetime)) do
      :eq ->
        case Date.compare(segment1.checkout_date, DateTime.to_date(segment2.end_datetime)) do
          :lt -> true
          _ -> false
        end

      :lt ->
        true

      _ ->
        false
    end
  end

  def compare(%HotelSegment{} = segment1, %HotelSegment{} = segment2) do
    case Date.compare(segment1.checkin_date, segment2.checkin_date) do
      :eq ->
        case DateTime.compare(segment1.checkout_date, segment2.checkout_date) do
          :lt -> true
          _ -> false
        end

      :lt ->
        true

      _ ->
        false
    end
  end
end
