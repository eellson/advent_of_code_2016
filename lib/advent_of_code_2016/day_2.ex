defmodule AdventOfCode.Day2 do
  alias AdventOfCode.Day2.Pad1

  def run(instructions) do
    {_, seq} =
      instructions
      |> to_char_list
      |> Enum.reduce({5, []}, &handle_instruction/2)

    Enum.reverse(seq)
  end

  def handle_instruction(?\n, {current, seq}), do: {current, [current|seq]}
  def handle_instruction(?U, {current, seq}), do: {Pad1.up(current), seq}
  def handle_instruction(?R, {current, seq}), do: {Pad1.right(current), seq}
  def handle_instruction(?D, {current, seq}), do: {Pad1.down(current), seq}
  def handle_instruction(?L, {current, seq}), do: {Pad1.left(current), seq}
end
