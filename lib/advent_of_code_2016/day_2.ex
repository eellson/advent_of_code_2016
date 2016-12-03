defmodule AdventOfCode.Day2 do
  alias AdventOfCode.Day2.Pad1

  def run(instructions) do
    {_, seq} =
      instructions
      |> to_char_list
      |> Enum.reduce({%Pad1{}, []}, &handle_instruction/2)

    seq |> Enum.reverse |> Enum.map(&(&1.current))
  end

  def handle_instruction(?\n, {current, seq}), do: {current, [current|seq]}
  def handle_instruction(?U, {%pad{} = current, seq}), do: {pad.up(current), seq}
  def handle_instruction(?R, {%pad{} = current, seq}), do: {pad.right(current), seq}
  def handle_instruction(?D, {%pad{} = current, seq}), do: {pad.down(current), seq}
  def handle_instruction(?L, {%pad{} = current, seq}), do: {pad.left(current), seq}
end
