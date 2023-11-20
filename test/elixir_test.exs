defmodule Tests do
  use ExUnit.Case
  doctest Lib

  test "example" do
    assert Lib.example(1, 2, 3) == {"1", "2", "6"}
  end

  test "timex_tests" do
    assert Lib.example1()
  end
end
