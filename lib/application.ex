defmodule Lib.Application do
  use Application

  def start(_type, _args) do
    out = ReservationTransformer.transform("input.txt")
    IO.puts(out)

    {:ok, self()}
  end
end
