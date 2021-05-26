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
  end
end
