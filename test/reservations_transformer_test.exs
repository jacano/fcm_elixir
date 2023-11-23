defmodule ReservationTransformerTests do
  use ExUnit.Case

  test "test_case" do
    out = String.trim(ReservationTransformer.transform("input.txt"))
    expected_out = String.trim(File.read!("expected_output.txt"))

    assert out == expected_out
  end
end
