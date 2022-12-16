defmodule TeslaDumper.MixProject do
  use Mix.Project

  @version "0.0.1"
  def project do
    [
      app: :tesla_dumper,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package(),
      description: description(),
      source_url: "https://github.com/beastia/tesla_dumper"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: ["Igor Pavlov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/beastia/tesla_dumper"}
    ]
  end

  defp description do
    "Simple dumper of Tesla Env to a playable curl request"
  end

  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:mimic, "~> 1.7.4", only: :test},
      {:bypass, "~> 2.1.0", only: :test},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
