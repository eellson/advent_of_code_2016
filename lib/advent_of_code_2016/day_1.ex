defmodule AdventOfCode.Day1 do
  def run(directions) do
    {_, {x, y}} =
      directions
      |> String.split(", ")
      |> Enum.reduce({:n, {0, 0}}, &do_move/2)

    abs(x) + abs(y)
  end

  def do_move("R" <> n, {:n, {x, y}}), do: {:e, {x + String.to_integer(n), y}}
  def do_move("L" <> n, {:n, {x, y}}), do: {:w, {x - String.to_integer(n), y}}
  def do_move("R" <> n, {:e, {x, y}}), do: {:s, {x, y - String.to_integer(n)}}
  def do_move("L" <> n, {:e, {x, y}}), do: {:n, {x, y + String.to_integer(n)}}
  def do_move("R" <> n, {:s, {x, y}}), do: {:w, {x - String.to_integer(n), y}}
  def do_move("L" <> n, {:s, {x, y}}), do: {:e, {x + String.to_integer(n), y}}
  def do_move("R" <> n, {:w, {x, y}}), do: {:n, {x, y + String.to_integer(n)}}
  def do_move("L" <> n, {:w, {x, y}}), do: {:s, {x, y - String.to_integer(n)}}
end
