defmodule AdventOfCode.Day5 do
  def run_a, do: "abc" |> new_hash_context |> search([])

  def search(hash_context, results), do: search(hash_context, results, 0)

  def search(hash_context, results, i) when length(results) == 8, do: results
  def search(hash_context, results, i) do
    results = 
      hash_context
      |> :crypto.hash_update(Integer.to_string(i))
      |> :crypto.hash_final
      |> Base.encode16
      |> handle_hex(results)

    search(hash_context, results, i + 1)
  end

  def handle_hex(<<"00000", char::binary-size(1), rest::binary>>, results) do
    [char|results]
  end
  def handle_hex(_hex, results), do: results

  def new_hash_context(data) do
    :md5 |> :crypto.hash_init |> :crypto.hash_update(data)
  end
end
