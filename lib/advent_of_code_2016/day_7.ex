defmodule AdventOfCode.Day7 do
  def run_a do
    "./lib/advent_of_code_2016/day_7/input.txt"
    |> File.read!
    |> parse
    |> Enum.filter(&no_abba_in_hype_seq?/1)
    |> Enum.filter(&abba_outside_hype_seq?/1)
    |> Enum.count
  end

  def run_b do
    "./lib/advent_of_code_2016/day_7/input.txt"
    |> File.read!
    |> parse
    |> Enum.map(&get_abas/1)
    |> Enum.filter(fn {abas, _} -> abas != [] end)
    |> Enum.map(&as_babs/1)
    |> Enum.filter(&bab_in_hype_seq?/1)
    |> Enum.count
  end

  def parse(string) do
    {:ok, tokens, _} = string |> String.to_charlist |> :ip_lexer.string
    {:ok, list} = :ip_parser.parse(tokens)
    list
  end

  def no_abba_in_hype_seq?(list), do: !Enum.any?(list, &is_hype_seq_with_abba?/1)

  def abba_outside_hype_seq?(list), do: Enum.any?(list, &not_hype_seq_with_abba?/1)

  def as_babs({abas, list}), do: {Enum.map(abas, fn [a,b,a] -> [b,a,b] end), list}

  def bab_in_hype_seq?({babs, list}) do
    Enum.any?(babs, &is_in_hype_seq?(&1, list))
  end

  def is_in_hype_seq?(bab, list) do
    Enum.any?(list, &is_hype_seq_with_bab?(bab, &1))
  end

  def get_abas(list) do
    abas =
      list
      |> Enum.reduce([], &not_hype_seq_with_aba/2)
      |> Enum.flat_map(&(&1))

    {abas, list}
  end

  def is_hype_seq_with_abba?({:hype, {:chars, contents}}), do: abba?(contents)
  def is_hype_seq_with_abba?({:chars, _}), do: false

  def is_hype_seq_with_bab?(_bab, {:chars, _}), do: false
  def is_hype_seq_with_bab?(bab, {:hype, {:chars, contents}}), do: bab?(bab, contents)

  def not_hype_seq_with_abba?({:hype, _}), do: false
  def not_hype_seq_with_abba?({:chars, chars}), do: abba?(chars)

  def not_hype_seq_with_aba({:hype, _}, acc), do: acc
  def not_hype_seq_with_aba({:chars, chars}, acc), do: [aba(chars, [])|acc]

  def abba?([a, b, b, a|rest]) when a !== b, do: true
  def abba?(chars) when length(chars) < 4, do: false
  def abba?([a|rest]), do: abba?(rest)

  def aba([a, b, a|rest], abas) when a !== b, do: aba([b, a|rest], [[a, b, a]|abas])
  def aba(chars, abas) when length(chars) < 3, do: abas
  def aba([a|rest], abas), do: aba(rest, abas)

  def bab?([b, a, b], [b, a, b|rest]), do: true
  def bab?(bab, sequence) when length(sequence) < 3, do: false
  def bab?(bab, [b|rest]), do: bab?(bab, rest)
end
