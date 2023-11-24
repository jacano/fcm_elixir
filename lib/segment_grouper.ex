defmodule SegmentGrouper do
  defp is_connected(%TravelSegment{} = item, %TravelSegment{} = prev_item, based) do
    prev_item.destination == item.origin && item.origin != based
  end

  defp is_connected(_, _, _) do
    true
  end

  # This function organizes the provide segment list into subgroups by evaluating if a segment and the previous one are connected and not based.
  # It recursively processes the list using tail recursion, forming subgroups until the list is exhausted.
  # It returns the grouped segments as a result and will retain the segments input order.
  def generate_sublists(items, based) do
    generate_sublists(items, [], [], based)
  end

  defp generate_sublists([item | rest], [], acc, based) do
    generate_sublists(rest, [item], acc, based)
  end

  defp generate_sublists([item | rest], [prev_item | _] = current_sublist, acc, based) do
    if is_connected(item, prev_item, based) do
      generate_sublists(rest, [item | current_sublist], acc, based)
    else
      generate_sublists(rest, [item], acc ++ [Enum.reverse(current_sublist)], based)
    end
  end

  defp generate_sublists([item | rest], current_sublist, acc, based) do
    generate_sublists(rest, [item], acc ++ [Enum.reverse(current_sublist)], based)
  end

  defp generate_sublists([], current_sublist, acc, based) do
    acc ++ [Enum.reverse(current_sublist)]
  end
end
