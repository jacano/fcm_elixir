defmodule Test.MixProject do
  use Mix.Project

  def project do
    [
      app: :test,
      version: "0.1.0",
      elixir: "~> 1.15.7",
      start_permanent: Mix.env() == :prod,
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Lib.Application, []}
    ]
  end
end
