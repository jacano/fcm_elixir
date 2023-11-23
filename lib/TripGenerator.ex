defmodule TripGenerator do
  defp is_connection(%TravelSegment{} = segment1, %TravelSegment{} = segment2) do
    diff = DateTime.diff(segment2.start_datetime, segment1.end_datetime, :hour)
    diff >= 0 && diff < 24
  end

  defp check_connection({elem, index}, list) do
    not(index < length(list) - 1 && is_connection(elem, Enum.at(list, index + 1)))
  end

  def only_travels_not_based(%TravelSegment{} = element, based) do
    element.destination != based
  end

  def only_travels_not_based(_, _) do
    false
  end

  def remove_connections(list) do
    Enum.filter(Enum.with_index(list), &check_connection(&1, list))
      |> Enum.map(fn {elem, _index} -> elem end)
  end

  def get_destination(%TravelSegment{} = element) do
    element.destination
  end
end
