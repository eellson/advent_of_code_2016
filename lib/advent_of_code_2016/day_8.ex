defmodule AdventOfCode.Day8 do
  def run_a do
    "./lib/advent_of_code_2016/day_8/input.txt"
    |> File.read!
    |> parse
    |> Enum.reduce(MapSet.new, &exec/2)
    |> IO.inspect
    |> Enum.count
  end

  def run_b do
    "./lib/advent_of_code_2016/day_8/input.txt"
    |> File.read!
    |> parse
    |> Enum.reduce(MapSet.new, &exec/2)
    |> Enum.group_by(&x_range/1)
    |> Enum.map(&into_letter/1)
    |> Enum.map(&print/1)
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

  def x_range({x, y}) when x in 0..4, do: 0
  def x_range({x, y}) when x in 5..9, do: 5
  def x_range({x, y}) when x in 10..14, do: 10
  def x_range({x, y}) when x in 15..19, do: 15
  def x_range({x, y}) when x in 20..24, do: 20
  def x_range({x, y}) when x in 25..29, do: 25
  def x_range({x, y}) when x in 30..34, do: 30
  def x_range({x, y}) when x in 35..39, do: 35
  def x_range({x, y}) when x in 40..44, do: 40
  def x_range({x, y}) when x in 45..49, do: 45

  def into_letter({mult, coords}) do
    row = for x <- Enum.map(0..4, &(&1 + mult)), into: %{}, do: {x, nil}
    base = for y <- 0..5, into: %{}, do: {y, row}

    Enum.reduce(coords, base, fn {x, y}, base -> put_in base[y][x], :on end)
  end

  def print(matrix) do
    Enum.each(matrix, &print_row/1)

    IO.puts("\r")
  end

  def print_row({_, map}), do: map |> Enum.map(&print_char/1) |> IO.puts

  def print_char({_, :on}), do: ?#
  def print_char(_), do: ?\s

  def parse(string) do
    {:ok, tokens, _} =
      string
      |> String.to_charlist
      |> :instruction_lexer.string

    {:ok, instructions} = :instruction_parser.parse(tokens)
    instructions
  end
end
