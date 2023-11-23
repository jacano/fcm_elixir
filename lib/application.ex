defmodule App do

  def start(_type, _args) do
    transformReservation("input.txt")
    {:ok, self()}
  end

  def main(args) do
    args |> parse_args |> process
  end

  def transformReservation(input_path) do
    out = ReservationTransformer.transform(input_path)
    IO.puts(out)
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [input: :string]
    )
    options
  end

  defp process([]) do
    IO.puts("No arguments given")
  end

  defp process(options) do
    input_path = options[:input]
    transformReservation(input_path)
  end
end
