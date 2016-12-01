defmodule AdventOfCode.Day1 do
  def run(directions) do
    {_, {x, y}} =
      directions
      |> String.split(", ")
      |> Enum.reduce({:n, {0, 0}}, &do_move/2)

    abs(x) + abs(y)
  end

  def do_move("R" <> distance, {:n, coords}), do: do_move(distance, {:e, coords})
  def do_move("R" <> distance, {:e, coords}), do: do_move(distance, {:s, coords})
  def do_move("R" <> distance, {:s, coords}), do: do_move(distance, {:w, coords})
  def do_move("R" <> distance, {:w, coords}), do: do_move(distance, {:n, coords})

  def do_move("L" <> distance, {:n, coords}), do: do_move(distance, {:w, coords})
  def do_move("L" <> distance, {:e, coords}), do: do_move(distance, {:n, coords})
  def do_move("L" <> distance, {:s, coords}), do: do_move(distance, {:e, coords})
  def do_move("L" <> distance, {:w, coords}), do: do_move(distance, {:s, coords})

  def do_move(string_distance, current) when is_binary string_distance do
    string_distance
    |> String.to_integer
    |> do_move(current)
  end

  def do_move(1, {:n, {x, y}}), do: {:n, {x, y + 1}}
  def do_move(1, {:e, {x, y}}), do: {:e, {x + 1, y}}
  def do_move(1, {:s, {x, y}}), do: {:s, {x, y - 1}}
  def do_move(1, {:w, {x, y}}), do: {:w, {x - 1, y}}

  def do_move(n, current) do
    next = do_move(1, current)
    do_move(n - 1, next)
  end
end
