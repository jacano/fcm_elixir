defmodule TripGenerator do
  # Checks if the endtime of the first segment (segment1) is within 24 hours before the starttime of the second segment (segment2)
  defp is_connection(%TravelSegment{} = segment1, %TravelSegment{} = segment2) do
    diff = DateTime.diff(segment2.start_datetime, segment1.end_datetime, :hour)
    diff >= 0 && diff < 24
  end

  def only_travels_not_based(%TravelSegment{} = element, based) do
    element.destination != based
  end

  def only_travels_not_based(_, _) do
    false
  end

  def remove_connections(list) do
    Enum.reject(
      Enum.with_index(list),
      fn {elem, index} -> index < length(list) - 1 && is_connection(elem, Enum.at(list, index + 1)) end)
    |> Enum.map(fn {elem, _index} -> elem end)
  end

end
