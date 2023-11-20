defmodule Lib.Application do
  use Application

  def start(_type, _args) do
    Lib.example(1, 2, 3)
    {:ok, self()}
  end
end
