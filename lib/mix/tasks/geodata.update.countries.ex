defmodule Mix.Tasks.Geodata.Update.Countries do
  use Mix.Task

  @shortdoc "Update Geodata Country Data"

  @moduledoc """
  Download and update the Countries Info data file used in the Country
  module. The data is downloaded into `priv/data/countries.csv`.

      mix geodata.update.countries
  """

  def run(_args) do
    Geodata.Countries.update()
    |> log_status()
  end

  defp log_status(status) do
    cond do
      status >= 200 && status <= 299 ->
        Mix.shell().info("\nCountry data updated.")

      status == 304 ->
        Mix.shell().info("\nNot Updated: Country data hasn't changed.")

      status >= 400 ->
        Mix.shell().error("\nError downloading country data.")

      true ->
        Mix.shell().error("\nError downloading country data.")
    end
  end
end
