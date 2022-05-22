defmodule Wabanex.Imc do
  @moduledoc """
  Catches data from a csv file and calculates the IMC.
  """

  @doc """
  Opens the csv file, parses the result and calculates the IMC.
  """
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_result()
  end

  defp handle_result({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_result({:error, _reason}) do
    {:error, "Error while opening the file"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
