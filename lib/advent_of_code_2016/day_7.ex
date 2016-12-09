defmodule AdventOfCode.Day7 do
  def run_a do
    "./lib/advent_of_code_2016/day_7/input.txt"
    |> File.read!
    |> parse
    |> Enum.filter(&no_abba_in_hype_seq?/1)
    |> Enum.filter(&abba_outside_hype_seq?/1)
    |> Enum.count
  end

  def parse(string) do
    {:ok, tokens, _} = string |> String.to_charlist |> :ip_lexer.string
    {:ok, list} = :ip_parser.parse(tokens)
    list
  end

  def no_abba_in_hype_seq?(list), do: !Enum.any?(list, &is_hype_seq_with_abba?/1)

  def abba_outside_hype_seq?(list), do: Enum.any?(list, &not_hype_seq_with_abba?/1)

  def is_hype_seq_with_abba?({:hype, {:chars, contents}}), do: abba?(contents)
  def is_hype_seq_with_abba?({:chars, _}), do: false

  def not_hype_seq_with_abba?({:hype, {:chars, contents}}), do: false
  def not_hype_seq_with_abba?({:chars, chars}), do: abba?(chars)

  def abba?([a, b, b, a|rest]) when a !== b, do: true
  def abba?(chars) when length(chars) < 4, do: false
  def abba?([a|rest]), do: abba?(rest)
end
