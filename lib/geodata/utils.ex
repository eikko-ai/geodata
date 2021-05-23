defmodule Geodata.Utils do
  alias Geodata.Countries

  @doc """
  Check if archive option is a member of the archives list
  """
  def in_archives?(archive) when is_atom(archive) do
    archive_exists?(archive)
  end

  def in_archives?(archive) when is_binary(archive) do
    archive_exists?(String.to_atom(archive))
  end

  def in_archives?(_) do
    false
  end

  defp archive_exists?(archive) do
    cond do
      is_valid_country_archive?(archive) -> true
      archive in Geodata.keys() -> true
      true -> false
    end
  end

  @doc """
  Checks if the archive is a country archive and if it's a valid country
  """
  def is_valid_country_archive?(archive) do
    with %{"code" => code} <- archive_country_code(archive),
         true <- Countries.is_country?(code) do
      true
    else
      _ -> false
    end
  end

  # Extracts the country ISO code from an archive
  def archive_country_code(archive) when is_binary(archive) do
    Regex.named_captures(~r/country_(?<code>[a-zA-Z]{2})/, archive)
  end

  def archive_country_code(archive) when is_atom(archive) do
    Regex.named_captures(~r/country_(?<code>[a-zA-Z]{2})/, Atom.to_string(archive))
  end
end
