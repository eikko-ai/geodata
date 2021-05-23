defmodule Geodata.MixProject do
  use Mix.Project

  @version "0.1.0"
  @repo_url "https://github.com/eikko-ai/geodata"

  def project do
    [
      app: :geodata,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      package: package(),
      description: "Geo data and utils"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ssl, :inets]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:flow, "~> 1.1"},
      {:nimble_csv, "~> 1.1"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @repo_url}
    ]
  end
end
