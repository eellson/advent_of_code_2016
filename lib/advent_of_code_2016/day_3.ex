defmodule AdventOfCode.Day3 do
  def run do
    "./lib/advent_of_code_2016/day_3/input.txt"
    |> File.read!
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&into_triangles/1)
    |> Enum.count(&valid_triangle?/1)
  end

  def run_b do
    "./lib/advent_of_code_2016/day_3/input.txt"
    |> File.read!
    |> String.split
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index
    |> Enum.group_by(fn {side, index} -> rem(index, 3) end)
    |> Map.values
    |> Enum.map(&only_values/1)
    |> List.flatten
    |> Enum.chunk(3)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.count(&valid_triangle?/1)
  end

  def into_triangles(string) do
    string
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  def valid_triangle?({a, b, c})
      when a + b > c and a + c > b and b + c > a, do: true
  def valid_triangle?({a, b, c}), do: false

  defp only_values(list), do: Enum.map(list, fn {side, index} -> side end)
end
