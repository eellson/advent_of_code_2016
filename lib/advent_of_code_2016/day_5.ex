defmodule AdventOfCode.Day5 do
  def run_a do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&hash_and_encode("ojvtpuvg", &1))
    |> Stream.filter_map(&five_zeros/1, &get_character/1)
    |> Enum.reduce_while([], &acc_incomplete/2)
    |> Enum.reverse
    |> List.to_string
  end

  def run_b do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&hash_and_encode("ojvtpuvg", &1))
    |> Stream.filter_map(&zeros_and_position/1, &pos_and_char_tuple/1)
    |> Enum.reduce_while([], &put_new/2)
    |> Enum.sort_by(fn {pos, char} -> pos |> Atom.to_string |> String.to_integer end)
    |> Enum.map(fn {pos, char} -> char end)
    |> List.to_string
  end

  def five_zeros(<<"00000", rest::binary>>), do: true
  def five_zeros(_hex), do: false

  @valid_positions ["0", "1", "2", "3", "4", "5", "6", "7"]
  def zeros_and_position(<<"00000", pos::binary-size(1), _rest::binary>>)
      when pos in @valid_positions do
        true
  end
  def zeros_and_position(_), do: false

  def pos_and_char_tuple(<<"00000", pos::binary-size(1), char::binary-size(1), _rest::binary>>) do
    {pos, char}
  end

  def acc_incomplete(_char, acc) when length(acc) >= 8, do: {:halt, acc}
  def acc_incomplete(char, acc), do: {:cont, [char|acc]} |> IO.inspect

  def put_new(_, keyword) when length(keyword) >= 8, do: {:halt, keyword}
  def put_new({pos, val}, keyword) do
    {:cont, Keyword.put_new(keyword, String.to_atom(pos), val)} |> IO.inspect
  end

  def get_character(<<"00000", char::binary-size(1), rest::binary>>), do: char

  def hash_and_encode(base, i) do
    :md5
    |> :crypto.hash([base, Integer.to_string(i)])
    |> Base.encode16(case: :lower)
  end
end
