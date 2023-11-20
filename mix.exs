defmodule Test.MixProject do
  use Mix.Project

  def project do
    [
      app: :test,
      version: "0.1.0",
      elixir: "~> 1.15.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Lib.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:timex, "~> 3.7"}
    ]
  end
end
