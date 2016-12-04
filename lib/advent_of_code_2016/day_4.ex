defmodule AdventOfCode.Day4 do
  def run do
    "./lib/advent_of_code_2016/day_4/input.txt"
    |> File.read!
    |> String.split
    |> Enum.map(&into_map/1)
    |> Enum.filter(&is_real?/1)
    |> Enum.map(fn %{"id" => id} -> String.to_integer(id) end)
    |> Enum.reduce(0, &+/2)
  end

  def into_map(string) do
    Regex.named_captures(~r/^(?<name>.+)-(?<id>\d+)\[(?<check>\w+)\]/, string)
  end

  def is_real?(%{"name" => name, "check" => check}) do
    calc_checksum(name) == check
  end

  def calc_checksum(name) do
    name
    |> String.to_charlist
    |> Enum.filter(&(&1 != ?-))
    |> Enum.reduce(%{}, &count_into/2)
    |> Enum.sort_by(fn {char, count} -> count end, &>=/2)
    |> Enum.map(fn {char, count} -> char end)
    |> Enum.take(5)
    |> List.to_string
  end

  def count_into(char, map), do: Map.update(map, char, 1, &(&1 + 1))
end
