defmodule AdventOfCode.Day2 do
  def run(instructions) do
    {_, seq} =
      instructions
      |> to_char_list
      |> Enum.reduce({5, []}, &handle_instruction/2)

    Enum.reverse(seq)
  end

  @doc """
  [1, 2, 3]
  [4, 5, 6]
  [7, 8, 9]
  """
  def handle_instruction(?U, {row_1, seq}) when row_1 in [1, 2, 3], do: {row_1, seq}
  def handle_instruction(?D, {row_3, seq}) when row_3 in [7, 8, 9], do: {row_3, seq}

  def handle_instruction(?L, {col_1, seq}) when col_1 in [1, 4, 7], do: {col_1, seq}
  def handle_instruction(?R, {col_3, seq}) when col_3 in [3, 6, 9], do: {col_3, seq}

  def handle_instruction(?\n, {n, seq}), do: {n, [n|seq]}
  def handle_instruction(?R, {1, seq}), do: {2, seq}
  def handle_instruction(?D, {1, seq}), do: {4, seq}

  def handle_instruction(?R, {2, seq}), do: {3, seq}
  def handle_instruction(?D, {2, seq}), do: {5, seq}
  def handle_instruction(?L, {2, seq}), do: {1, seq}

  def handle_instruction(?D, {3, seq}), do: {6, seq}
  def handle_instruction(?L, {3, seq}), do: {2, seq}

  def handle_instruction(?U, {4, seq}), do: {1, seq}
  def handle_instruction(?R, {4, seq}), do: {5, seq}
  def handle_instruction(?D, {4, seq}), do: {7, seq}

  def handle_instruction(?U, {5, seq}), do: {2, seq}
  def handle_instruction(?R, {5, seq}), do: {6, seq}
  def handle_instruction(?D, {5, seq}), do: {8, seq}
  def handle_instruction(?L, {5, seq}), do: {4, seq}

  def handle_instruction(?U, {6, seq}), do: {3, seq}
  def handle_instruction(?D, {6, seq}), do: {9, seq}
  def handle_instruction(?L, {6, seq}), do: {5, seq}

  def handle_instruction(?U, {7, seq}), do: {4, seq}
  def handle_instruction(?R, {7, seq}), do: {8, seq}

  def handle_instruction(?U, {8, seq}), do: {5, seq}
  def handle_instruction(?R, {8, seq}), do: {9, seq}
  def handle_instruction(?L, {8, seq}), do: {7, seq}

  def handle_instruction(?U, {9, seq}), do: {6, seq}
  def handle_instruction(?L, {9, seq}), do: {8, seq}
end
