defmodule AdventOfCode.Day8 do
  def run_a do
    "./lib/advent_of_code_2016/day_8/input.txt"
    |> File.read!
    |> parse
    |> Enum.reduce(MapSet.new, &exec/2)
    |> IO.inspect
    |> Enum.count
  end

  def exec({:rect, {x, y}}, on) do
    for x <- 0..x - 1, y <- 0..y - 1, into: on, do: {x, y}
  end
  def exec({:rot, {:row, y}, shift}, on) do
    with to_rotate <- Enum.filter(on, &match?({_, ^y}, &1)),
         rotated_to <- Enum.map(to_rotate, fn {x, y} -> {rem(x + shift, 50), y} end),
      do: delete_and_put(on, to_rotate, rotated_to)
  end
  def exec({:rot, {:col, x}, shift}, on) do
    with to_rotate <- Enum.filter(on, &match?({^x, _}, &1)),
         rotated_to <- Enum.map(to_rotate, fn {x, y} -> {x, rem(y + shift, 6)} end),
      do: delete_and_put(on, to_rotate, rotated_to)
  end

  def delete_and_put(on, to_delete, to_put) do
    with on <- Enum.reduce(to_delete, on, &(MapSet.delete(&2, &1))),
      do: Enum.reduce(to_put, on, &(MapSet.put(&2, &1)))
  end

  def parse(string) do
    {:ok, tokens, _} =
      string
      |> String.to_charlist
      |> :instruction_lexer.string

    {:ok, instructions} = :instruction_parser.parse(tokens)
    instructions
  end
end
