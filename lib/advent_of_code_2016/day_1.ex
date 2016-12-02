defmodule AdventOfCode.Day1 do
  def run(directions) do
    {_, {x, y}} =
      directions
      |> into_keyword
      |> Enum.reduce({:n, {0, 0}}, &do_move/2)

    abs(x) + abs(y)
  end


  @doc """
  Handle rotation or translation, returning transformed {bearing, coordinates}
  """
  def do_move({:rotation, ?R}, {:n, coords}), do: {:e, coords}
  def do_move({:rotation, ?R}, {:e, coords}), do: {:s, coords}
  def do_move({:rotation, ?R}, {:s, coords}), do: {:w, coords}
  def do_move({:rotation, ?R}, {:w, coords}), do: {:n, coords}

  def do_move({:rotation, ?L}, {:n, coords}), do: {:w, coords}
  def do_move({:rotation, ?L}, {:e, coords}), do: {:n, coords}
  def do_move({:rotation, ?L}, {:s, coords}), do: {:e, coords}
  def do_move({:rotation, ?L}, {:w, coords}), do: {:s, coords}

  def do_move({:translation, n}, {:n, {x, y}}), do: {:n, {x, y + n}}
  def do_move({:translation, n}, {:e, {x, y}}), do: {:e, {x + n, y}}
  def do_move({:translation, n}, {:s, {x, y}}), do: {:s, {x, y - n}}
  def do_move({:translation, n}, {:w, {x, y}}), do: {:w, {x - n, y}}

  @doc """
  Takes list of instructions, turning into Keyword representation.
  """
  def into_keyword(directions_string) do
    directions_string
    |> String.split(", ")
    |> Enum.map(&to_tuple/1)
    |> Enum.map(&to_instruction_tuple/1)
    |> List.flatten
    |> Enum.map(&to_unary_translation/1)
    |> List.flatten
  end

  defp to_tuple(<<rotation::size(8)>> <> translation) do
    {rotation, String.to_integer(translation)}
  end

  defp to_instruction_tuple({rotation, translation}) do
    [{:rotation, rotation}, {:translation, translation}]
  end

  defp to_unary_translation({:rotation, _} = rotation), do: rotation
  defp to_unary_translation({:translation, translation}) do
    for i <- 1..translation, do: {:translation, 1}
  end
end
