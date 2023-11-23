defmodule SegmentGrouper do

  defp is_based_open(%TravelSegment{} = item, based) do
    item.origin == based
  end

  defp is_based_open(%HotelSegment{} = item, based) do
    item.location == based
  end

  defp is_based_close(%TravelSegment{} = item, based) do
    item.destination == based
  end

  defp is_based_close(%HotelSegment{} = item, based) do
    item.location == based
  end

  def group_segments(list, based) do
    group_segments(list, [], [], based)
  end

  defp group_segments([], current_subgroup, result, _) do
    Enum.reverse([Enum.reverse(current_subgroup) | result])
  end

  defp group_segments([item | rest], [], result, based) do
    if is_based_open(item, based) do
      group_segments(rest, [item], result, based)
    else
      group_segments(rest, [], [item | result], based)
    end
  end

  defp group_segments([item | rest], current_subgroup, result, based) do
    if is_based_close(item, based) do
      group_segments(rest, [], [Enum.reverse([item | current_subgroup]) | result], based)
    else
      group_segments(rest, [item | current_subgroup], result, based)
    end
  end
end
