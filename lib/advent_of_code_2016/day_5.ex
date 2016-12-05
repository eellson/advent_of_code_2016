defmodule AdventOfCode.Day5 do
  def run_a do
    hash_context = "ojvtpuvg" |> new_hash_context

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while([], fn
      _n, acc when length(acc) >= 8 -> {:halt, acc}
      n, acc -> test(hash_context, acc, n, &handle_hex/2)
    end)
  end

  def test(hash_context, acc, i, test_and_accumulate_fn) do
    acc =
      hash_context
      |> :crypto.hash_update(Integer.to_string(i))
      |> :crypto.hash_final
      |> Base.encode16(case: :lower)
      |> test_and_accumulate_fn.(acc)

    {:cont, acc}
  end

  def handle_hex(<<"00000", rest::binary>>, acc), do: [rest|acc] |> IO.inspect
  def handle_hex(_hex, acc), do: acc

  def get_character(<<char::binary-size(1), rest::binary>>), do: char

  def new_hash_context(data) do
    :md5 |> :crypto.hash_init |> :crypto.hash_update(data)
  end
end
