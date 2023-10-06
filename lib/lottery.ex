defmodule Lottery do
  @moduledoc """
  Documentation for `Lottery`.
  """

  require Logger
  alias CSV

  def read_csv(filename) do
    filename
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.map(fn data -> data end)
    |> parse_wins
    |> winning_number_frequencies
  end

  defp parse_wins(data) do
    data
    |> Enum.map(fn {:ok, %{"Winning Numbers" => winner}} ->
      parse_numbers(winner)
    end)
  end

  defp parse_numbers(num) do
    all_num =
      num
      |> String.split(" ")

    {winners, [powerball | _]} = Enum.split(all_num, 5)
    %{w: winners, p: powerball}
  end

  defp winning_number_frequencies(data) do
    initial_state = %{powerball_frequencies: %{}, winning_number_frequencies: %{}}

    data
    |> Enum.reduce(initial_state, fn %{p: p, w: w}, acc ->
      singles = Map.update(acc.powerball_frequencies, p, 1, &(&1 + 1))

      cumulatives =
        Enum.reduce(w, acc.winning_number_frequencies, fn item, acc2 ->
          Map.update(acc2, item, 1, &(&1 + 1))
        end)

      %{acc | powerball_frequencies: singles, winning_number_frequencies: cumulatives}
    end)
    |> Enum.map(fn {k, freq} ->
      s = freq |> Enum.sort_by(&elem(&1, 1), :desc)
      {k, s}
    end)
  end
end
