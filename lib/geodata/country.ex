defmodule Geodata.Country do
  defstruct [
    :iso_3,
    :iso_numeric,
    :fips,
    :name,
    :capital,
    :area,
    :population,
    :continent,
    :tld,
    :currency_code,
    :currency_name,
    :phone,
    :postal_code_format,
    :postal_code_regex,
    :languages,
    :geoname_id,
    :neighbours,
    :equivalent_fips_code
  ]

  def new(attrs \\ []) do
    struct!(__MODULE__, attrs)
  end

  def map_row([iso_code | row]) do
    {iso_code,
     new(
       iso_3: Enum.at(row, 0),
       iso_numeric: Enum.at(row, 1),
       fips: Enum.at(row, 2),
       name: Enum.at(row, 3),
       capital: Enum.at(row, 4),
       area: Enum.at(row, 5) |> parse_number(),
       population: Enum.at(row, 6) |> parse_number(),
       continent: Enum.at(row, 7),
       tld: Enum.at(row, 8),
       currency_code: Enum.at(row, 9),
       currency_name: Enum.at(row, 10),
       phone: Enum.at(row, 11),
       postal_code_format: Enum.at(row, 12),
       postal_code_regex: Enum.at(row, 13),
       languages: Enum.at(row, 14),
       geoname_id: Enum.at(row, 15),
       neighbours: Enum.at(row, 16),
       equivalent_fips_code: Enum.at(row, 17)
     )}
  end

  defp parse_number(str) do
    case Float.parse(str) do
      {value, ""} -> value
      :error -> parse_integer(str)
      _ -> str
    end
  end

  defp parse_integer(str) do
    case Integer.parse(str) do
      {value, ""} -> value
      :error -> str
      _ -> str
    end
  end
end
