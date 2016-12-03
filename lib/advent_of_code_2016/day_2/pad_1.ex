defmodule AdventOfCode.Day2.Pad1 do
  @moduledoc """
  [1, 2, 3]
  [4, 5, 6]
  [7, 8, 9]
  """

  def up(from) when from in [1, 2, 3], do: from
  def up(n), do: n - 3

  def down(from) when from in [7, 8, 9], do: from
  def down(n), do: n + 3

  def left(from) when from in [1, 4, 7], do: from
  def left(n), do: n - 1

  def right(from) when from in [3, 6, 9], do: from
  def right(n), do: n + 1
end
