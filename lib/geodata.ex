defmodule Geodata do
  @moduledoc false

  import Geodata.Utils

  @base_url "http://download.geonames.org"

  def archives do
    [
      country_XX: %{
        schema: "GeoName",
        filename: "XX.zip",
        description: "Features for country with iso code XX"
      },
      no_country: %{
        schema: "GeoName",
        filename: "no-country.zip",
        description: "Features not belonging to a country"
      },
      all_countries: %{
        schema: "GeoName",
        filename: "allCountries.zip",
        description: "All countries features combined in one file"
      },
      cities_500: %{
        schema: "GeoName",
        filename: "cities500.zip",
        description: "Features for cities with a population > 500"
      },
      cities_1000: %{
        schema: "GeoName",
        filename: "cities1000.zip",
        description: "Features for cities with a population > 1 000"
      },
      cities_5000: %{
        schema: "GeoName",
        filename: "cities5000.zip",
        description: "Features for cities with a population > 5 000"
      },
      cities_15000: %{
        schema: "GeoName",
        filename: "cities15000.zip",
        description: "Features for cities with a population > 15 000"
      },
      # alternate_names: %{
      #   schema: "GeoAlternateName",
      #   filename: "alternateNamesV2.zip",
      #   description: "Alternate names with language codes and geonameId"
      # },
      admin_divisions: %{
        schema: "GeoAdminDivision",
        filename: "admin1CodesASCII.txt",
        description: "Names in English for admin divisions"
      },
      admin_subdivisions: %{
        schema: "GeoAdminSubdivision",
        filename: "admin2Codes.txt",
        description: "Names for administrative subdivision"
      },
      admin_code_5: %{
        schema: "GeoAdminNewCode",
        filename: "adminCode5.zip",
        description: "Additional division code"
      },
      language_codes: %{
        schema: "GeoLanguagecode",
        filename: "iso-languagecodes.txt",
        description: "ISO-639 language codes"
      },
      feature_codes: %{
        schema: "GeoFeature",
        filename: "featureCodes_en.txt",
        description: "Name and description for feature classes and feature codes "
      },
      timezones: %{
        schema: "GeoTimezone",
        filename: "timeZones.txt",
        description: "GMT, DST and Raw offsets"
      },
      country_info: %{
        schema: "GeoCountry",
        filename: "countryInfo.txt",
        description: "Country information"
      },
      user_tags: %{
        schema: "GeoUserTag",
        filename: "userTags.zip",
        description: "User contributed tags"
      },
      hierarchy: %{
        schema: "GeoHierarchy",
        filename: "hierarchy.zip",
        description: "Hierarchies"
      },
      shapes: %{
        schema: "GeoShape",
        filename: "shapes_all_low.zip",
        ignore_header: true,
        description: "Simplified country boundaries"
      }
    ]
  end

  @doc """
  All archive keys
  """
  def keys, do: archives() |> Keyword.keys()

  @doc """
  Get the full url for the given archive
  """
  def archive_url(archive) when is_atom(archive) do
    if in_archives?(archive) do
      cond do
        is_valid_country_archive?(archive) ->
          dump_url() <> country_archive_filename(archive)

        archive ->
          dump_url() <> archive_filename(archive)

        true ->
          nil
      end
    else
      {:error, "Not a valid geodata archive"}
    end
  end

  def archive_url(archive) when is_binary(archive) do
    archive
    |> String.to_atom()
    |> archive_url()
  end

  @doc """
  Get the filename of an archive file (non country type)
  """
  def archive_filename(archive) do
    archives() |> Keyword.get(archive) |> Map.get(:filename)
  end

  @doc """
  Get the filename of a country archive file (XX.zip)
  """
  def country_archive_filename(archive) do
    case archive_country_code(archive) do
      %{"code" => code} -> String.upcase(code) <> ".zip"
      _ -> false
    end
  end

  @doc """
  Get the geonames.org url for dump files
  """
  def dump_url, do: @base_url <> "/export/dump/"

  @doc """
  Get the geonames.org url for zip files
  """
  def zip_url, do: @base_url <> "/export/zip/"
end
