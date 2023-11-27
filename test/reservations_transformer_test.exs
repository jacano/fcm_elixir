defmodule ReservationTransformerTests do
  use ExUnit.Case

  test "test_case" do
    expected_out = String.trim(File.read!("test_cases/example/expected_output.txt"))

    out = String.trim(ReservationTransformer.transform("test_cases/example/input.txt"))

    assert expected_out == out
  end

  test "train_connection" do
    expected_out = String.trim(File.read!("test_cases/train_connection/expected_output.txt"))

    out = String.trim(ReservationTransformer.transform("test_cases/train_connection/input.txt"))

    assert expected_out == out
  end

  test "trips_without_return_to_based" do
    expected_out =
      String.trim(File.read!("test_cases/trips_without_return_to_based/expected_output.txt"))

    out =
      String.trim(
        ReservationTransformer.transform("test_cases/trips_without_return_to_based/input.txt")
      )

    assert expected_out == out
  end
end
