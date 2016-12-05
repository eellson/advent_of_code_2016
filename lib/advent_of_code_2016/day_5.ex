defmodule AdventOfCode.Day5 do
  def run_a do
    hash_context = "ojvtpuvg" |> new_hash_context

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while([], fn
      _n, acc when length(acc) >= 8 -> {:halt, acc}
      n, acc -> test(hash_context, acc, n)
    end)
  end

  def test(hash_context, acc, i) do
    acc =
      hash_context
      |> :crypto.hash_update(Integer.to_string(i))
      |> :crypto.hash_final
      |> Base.encode16
      |> handle_hex(acc)

    {:cont, acc}
  end

  def handle_hex(<<"00000", char::binary-size(1), rest::binary>>, acc) do
    [char|acc]
  end
  def handle_hex(_hex, acc), do: acc

  def new_hash_context(data) do
    :md5 |> :crypto.hash_init |> :crypto.hash_update(data)
  end
end
