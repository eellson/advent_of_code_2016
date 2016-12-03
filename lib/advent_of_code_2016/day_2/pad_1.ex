defmodule AdventOfCode.Day2.Pad1 do
  alias AdventOfCode.Day2.Pad1

  @moduledoc """
  [1, 2, 3]
  [4, 5, 6]
  [7, 8, 9]
  """

  defstruct [current: 5]

  def up(%Pad1{current: from} = pad) when from in [1, 2, 3], do: pad
  def up(%Pad1{current: n}), do: %Pad1{current: n - 3}

  def down(%Pad1{current: from} = pad) when from in [7, 8, 9], do: pad
  def down(%Pad1{current: n}), do: %Pad1{current: n + 3}

  def left(%Pad1{current: from} = pad) when from in [1, 4, 7], do: pad
  def left(%Pad1{current: n}), do: %Pad1{current: n - 1}

  def right(%Pad1{current: from} = pad) when from in [3, 6, 9], do: pad
  def right(%Pad1{current: n}), do: %Pad1{current: n + 1}
end
