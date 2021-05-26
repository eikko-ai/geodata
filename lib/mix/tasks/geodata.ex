defmodule Mix.Tasks.Geodata do
  use Mix.Task

  @shortdoc "Prints Geodata help information"

  @moduledoc """
  Prints Geodata tasks and their information.
      mix geodata
  """

  @doc false
  def run(args) do
    {_opts, args} = OptionParser.parse!(args, strict: [])

    case args do
      [] -> help()
      _ -> Mix.raise("Invalid arguments, expected: mix geodata")
    end
  end

  defp help() do
    Mix.Task.run("app.start")
    Mix.shell().info("Geodata v#{Application.spec(:geodata, :vsn)}")
    Mix.shell().info("An Elixir library to download and manage geo data from geonames.org.")
    Mix.shell().info("\nAvailable tasks:\n")
    Mix.Tasks.Help.run(["--search", "geodata."])
    Mix.shell().info("\n")
  end
end
