defmodule AdventOfCode.Day6 do
  def run_a do
    "./lib/advent_of_code_2016/day_6/input.txt"
    |> File.read!
    |> String.split
    |> Enum.map(&String.to_charlist/1)
    |> Enum.flat_map(&Enum.with_index/1)
    |> Enum.group_by(&elem(&1, 1))
    |> Map.values
    |> Enum.map(&count_values/1)
    |> Enum.map(&highest_count/1)
    |> Enum.map(&elem(&1, 0))
  end

  def count_values(list) do
    Enum.reduce(list, %{}, &count_into/2)
  end

  def count_into({value, _}, map), do: Map.update(map, value, 1, &(&1 + 1))

  def highest_count(map), do: Enum.max_by(map, fn {value, count} -> count end)
end
