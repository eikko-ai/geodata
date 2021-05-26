defmodule Geodata.Countries do
  @moduledoc """
  Functionality and utilities related to country data.
  As accessing country data can be frequent, keeping country
  data in memory can be useful to reduce DB hits.

  Country data file is located in `priv/data/countries.json`.
  """

  import Geodata.Parser
  alias Geodata.Request
  alias Geodata.Country

  @url "http://download.geonames.org/export/dump/countryInfo.txt"
  @data_file "priv/data/countries.csv"

  @eu_members ~w(
    AT BE BG CY CZ DK DE EE EL ES FI HR
    HU IE IT FR LV LT LU MT NL PL PT RO
    SI SK SE)a

  @efta_members ~w(CH IS LI NO)a

  @doc """
  Returns a list with all the countries ISO codes
  """
  def all() do
    countries()
  end

  @doc """
  Return a list with all country codes
  """
  def codes() do
    all() |> Map.keys()
  end

  def eu_members, do: @eu_members

  def efta_members, do: @efta_members

  @doc """
  Get a country by its country ISO-2 code
  """
  def get(country_code) when is_binary(country_code) do
    country = String.upcase(country_code)
    countries() |> Map.get(country)
  end

  def get(country_code) when is_atom(country_code) do
    country_code |> Atom.to_string() |> get()
  end

  def filter_by(attribute, value) when is_atom(attribute) do
    countries()
    |> Map.values()
    |> Enum.filter(&(Map.get(&1, attribute) == value))
  end

  def filter_by(attribute, value) when is_binary(attribute) do
    attribute
    |> String.downcase()
    |> String.to_atom()
    |> filter_by(value)
  end

  @doc """
  Checks if country with country_code exists
  """
  def is_country?(country_code) do
    !!get(country_code)
  end

  @doc """
  Checks if any country with attribute value exists
  """
  def exists?(attribute, value) when is_binary(attribute) do
    filter_by(attribute, value) |> length() > 0
  end

  def exists?(attribute, value) when is_atom(attribute) do
    filter_by(Atom.to_string(attribute), value) |> length() > 0
  end

  def is_eu_member?(country_code) when is_binary(country_code) do
    country =
      country_code
      |> String.upcase()
      |> String.to_atom()

    country in @eu_members
  end

  def is_eu_member?(country_code) when is_atom(country_code) do
    country_code |> Atom.to_string() |> is_eu_member?()
  end

  @doc """
  Update the country data file.
  """
  def update() do
    {status, data} = fetch_file(@url)

    data
    |> tsv_parse_string()
    |> tsv_dump()
    |> then(&File.write!(data_path(), &1))

    status
  end

  defp fetch_file(url) do
    %{body: data, status: status} = Request.get!(url)
    {status, data}
  end

  defp data_path do
    Application.app_dir(:geodata, @data_file)
  end

  defp countries do
    File.stream!(data_path())
    |> tsv_parse_stream()
    |> Enum.into(%{}, &Country.map_row/1)
  end
end
