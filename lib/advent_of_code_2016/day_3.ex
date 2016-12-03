defmodule AdventOfCode.Day3 do
  def run do
    "./lib/advent_of_code_2016/day_3/input.txt"
    |> File.read!
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&into_triangles/1)
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
end
