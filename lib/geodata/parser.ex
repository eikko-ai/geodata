defmodule Geodata.Parser do
  @moduledoc """
  Parser for Geonames data files
  """

  NimbleCSV.define(TSV, separator: "\t", escape: "\"")

  @comment "#"

  def tsv_parse_string(data, opts \\ []) do
    data
    |> TSV.parse_string(opts)
    |> Enum.reject(&is_comment?/1)
  end

  def tsv_parse_stream(data, opts \\ []) do
    data
    |> TSV.parse_stream(opts)
    |> Stream.reject(&is_comment?/1)
  end

  def tsv_dump(data) do
    TSV.dump_to_iodata(data)
  end

  defp is_comment?(row) when is_list(row) do
    row
    |> List.first()
    |> String.at(0) == @comment
  end

  defp is_comment?(row), do: row
end
