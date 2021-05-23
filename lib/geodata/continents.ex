defmodule Geodata.Continents do
  @moduledoc """
  All functionality related to Continent data.
  """

  defp continents do
    [
      AF: %{name: "Africa", id: "6255146"},
      AS: %{name: "Asia", id: "6255147"},
      EU: %{name: "Europe", id: "6255148"},
      NA: %{name: "North America", id: "6255149"},
      SA: %{name: "South America", id: "6255150"},
      OC: %{name: "Oceania", id: "6255151"},
      AN: %{name: "Antarctica", id: "6255152"}
    ]
  end

  def all() do
    continents()
  end

  def codes() do
    continents() |> Keyword.keys()
  end

  @doc """
  Returns the name value of the Continent when
  passing the code (:AF, :AS, :EU, :NA, :OC, :SA, :AN)
  """
  def continent_name(continent_code) do
    continents() |> Keyword.get(continent_code)
  end

  @doc """
  Returns a tuple with the continente code and name.
  """
  def continent_code(continent_name) do
    {code, _} = continents() |> List.keyfind(continent_name, 1)
    code
  end

  def exists?(continent_code) do
    continents() |> Keyword.has_key?(continent_code)
  end
end
