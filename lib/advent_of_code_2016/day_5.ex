defmodule AdventOfCode.Day5 do
  def run_a do
    hash_context = "ojvtpuvg" |> new_hash_context

    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&finalize_and_encode(hash_context, &1))
    |> Stream.filter(fn hex -> test_with(hex, &handle_hex/1) end)
    |> Enum.reduce_while([], fn
      _hex, acc when length(acc) >= 8 -> {:halt, acc}
      hex, acc -> {:cont, [hex|acc]} |> IO.inspect
    end)
    |> Enum.map(&get_character/1)
    |> Enum.reverse
    |> List.to_string
  end

  def run_b do
    hash_context = "ojvtpuvg" |> new_hash_context

    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&finalize_and_encode(hash_context, &1))
    |> Stream.filter(fn hex -> test_with(hex, &handle_hex/1) end)
    |> Enum.reduce_while([], fn
      _hex, acc when length(acc) >= 8 -> {:halt, acc}
      hex, acc ->
        acc = hex |> pos_and_char |> put_new_if_valid(acc)

        {:cont, acc} |> IO.inspect
    end)
    |> Enum.sort_by(fn {pos, char} -> pos |> Atom.to_string |> String.to_integer end)
    |> Enum.map(fn {pos, char} -> char end)
    |> List.to_string
  end

  def test_with(hash_context, test_fn), do: hash_context |> test_fn.()

  def handle_hex(<<"00000", rest::binary>>), do: true
  def handle_hex(_hex), do: false

  def pos_and_char(<<"00000",
                     pos::binary-size(1),
                     char::binary-size(1),
                     _rest::binary>>) do
    {pos, char}
  end

  @valid_positions ["0", "1", "2", "3", "4", "5", "6", "7"]
  def put_new_if_valid({pos, val}, keyword) when pos in @valid_positions do
    Keyword.put_new(keyword, String.to_atom(pos), val)
  end
  def put_new_if_valid(_, keyword), do: keyword

  def get_character(<<"00000", char::binary-size(1), rest::binary>>), do: char

  def new_hash_context(data) do
    :md5 |> :crypto.hash_init |> :crypto.hash_update(data)
  end

  def finalize_and_encode(hash_context, i) do
    hash_context
    |> :crypto.hash_update(Integer.to_string(i))
    |> :crypto.hash_final
    |> Base.encode16(case: :lower)
  end
end
