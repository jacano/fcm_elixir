defmodule Lib do

  def example(a, b, c) do
    step0 = to_string(a)
    step1 = to_string(b)
    step2 = to_string(c * 2)
    {step0, step1, step2}
  end

  def example1() do
    t = Timex.parse!("2023-01-05", "{YYYY}-{0M}-{0D}")
    {t}
  end
end
