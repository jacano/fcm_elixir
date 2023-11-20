defmodule Lib do

  def example(a, b, c) do
    step0 = to_string(a)
    step1 = to_string(b)
    step2 = to_string(c * 2)
    {step0, step1, step2}
  end
end
