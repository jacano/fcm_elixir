defmodule ReservationTransformerTests do
  use ExUnit.Case

  test "test_case" do
    out = String.trim(ReservationTransformer.transform("test_cases/example/input.txt"))
    expected_out = String.trim(File.read!("test_cases/example/expected_output.txt"))

    assert out == expected_out
  end

  test "train_connection" do
    out = String.trim(ReservationTransformer.transform("test_cases/train_connection/input.txt"))
    expected_out = String.trim(File.read!("test_cases/train_connection/expected_output.txt"))

    assert out == expected_out
  end

  test "trips_without_return_to_based" do
    out = String.trim(ReservationTransformer.transform("test_cases/trips_without_return_to_based/input.txt"))
    expected_out = String.trim(File.read!("test_cases/trips_without_return_to_based/expected_output.txt"))

    assert out == expected_out
  end
end
