defmodule AdventOfCode.Day2.Pad2 do
  alias AdventOfCode.Day2.Pad2

  @moduledoc """
      1
    2 3 4
  5 6 7 8 9
    A B C
      D
  """

  defstruct [current: 5]

  def up(%Pad2{current: from} = pad) when from in [1, 2, 4, 5, 9], do: pad
  def up(%Pad2{current: 3}), do: %Pad2{current: 1}
  def up(%Pad2{current: 6}), do: %Pad2{current: 2}
  def up(%Pad2{current: 7}), do: %Pad2{current: 3}
  def up(%Pad2{current: 8}), do: %Pad2{current: 4}
  def up(%Pad2{current: :a}), do: %Pad2{current: 6}
  def up(%Pad2{current: :b}), do: %Pad2{current: 7}
  def up(%Pad2{current: :c}), do: %Pad2{current: 8}
  def up(%Pad2{current: :d}), do: %Pad2{current: :b}

  def down(%Pad2{current: from} = pad) when from in [5, :a, :d, :c, 9], do: pad
  def down(%Pad2{current: 1}), do: %Pad2{current: 3}
  def down(%Pad2{current: 2}), do: %Pad2{current: 6}
  def down(%Pad2{current: 3}), do: %Pad2{current: 7}
  def down(%Pad2{current: 4}), do: %Pad2{current: 8}
  def down(%Pad2{current: 6}), do: %Pad2{current: :a}
  def down(%Pad2{current: 7}), do: %Pad2{current: :b}
  def down(%Pad2{current: 8}), do: %Pad2{current: :c}
  def down(%Pad2{current: :b}), do: %Pad2{current: :d}

  def left(%Pad2{current: from} = pad) when from in [1, 2, 5, :a, :d], do: pad
  def left(%Pad2{current: 3}), do: %Pad2{current: 2}
  def left(%Pad2{current: 4}), do: %Pad2{current: 3}
  def left(%Pad2{current: 6}), do: %Pad2{current: 5}
  def left(%Pad2{current: 7}), do: %Pad2{current: 6}
  def left(%Pad2{current: 8}), do: %Pad2{current: 7}
  def left(%Pad2{current: 9}), do: %Pad2{current: 8}
  def left(%Pad2{current: :b}), do: %Pad2{current: :a}
  def left(%Pad2{current: :c}), do: %Pad2{current: :b}

  def right(%Pad2{current: from} = pad) when from in [1, 4, 9, :c, :d], do: pad
  def right(%Pad2{current: 2}), do: %Pad2{current: 3}
  def right(%Pad2{current: 3}), do: %Pad2{current: 4}
  def right(%Pad2{current: 5}), do: %Pad2{current: 6}
  def right(%Pad2{current: 6}), do: %Pad2{current: 7}
  def right(%Pad2{current: 7}), do: %Pad2{current: 8}
  def right(%Pad2{current: 8}), do: %Pad2{current: 9}
  def right(%Pad2{current: :a}), do: %Pad2{current: :b}
  def right(%Pad2{current: :b}), do: %Pad2{current: :c}
end
