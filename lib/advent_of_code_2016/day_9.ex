defmodule AdventOfCode.Day9 do
  def run_a do
    "./lib/advent_of_code_2016/day_9/input.txt"
    |> File.read!()
    |> decompress()
    |> String.length()
  end

  # this takes 20 mins to run pls don't judge me programming gods
  def run_b do
    "./lib/advent_of_code_2016/day_9/input.txt"
    |> File.read!()
    |> calc_decompress_size()
  end

  def calc_decompress_size(string), do: string |> scan_for_markers_ii()

  def scan_for_markers_ii(string), do: do_scan_for_markers_ii(string, 0)

  def do_scan_for_markers_ii("", size), do: size
  def do_scan_for_markers_ii("(" <> rest, size) do
    count_decompress(rest, size)
  end
  def do_scan_for_markers_ii(<<char::binary-size(1), rest::binary>>, size) do
    do_scan_for_markers_ii(rest, size + 1)
  end

  def count_decompress(string, size) do
    %{"len" => len, "rep" => rep, "next" => next} =
      ~r/(?<len>\d+)x(?<rep>\d+)\)(?<next>.*)/
      |> Regex.named_captures(string)

    {to_rep, remaining} = String.split_at(next, String.to_integer(len))

    expansion = String.duplicate(to_rep, String.to_integer(rep))

    size = do_scan_for_markers_ii(expansion, size)
    do_scan_for_markers_ii(remaining, size)
  end

  def decompress(string), do: string |> scan_for_markers()

  def scan_for_markers(string), do: do_scan_for_markers(string, [])

  def do_scan_for_markers("", decompressed) do
    decompressed |> Enum.reverse |> Enum.join
  end
  def do_scan_for_markers("(" <> rest, decompressed) do
     marker_state(rest, decompressed)
  end
  def do_scan_for_markers(<<char::binary-size(1), rest::binary>>, decompressed) do
    do_scan_for_markers(rest, [char|decompressed])
  end

  def marker_state(string, decompressed) do
    %{"len" => len, "rep" => rep, "next" => next} =
      ~r/(?<len>\d+)x(?<rep>\d+)\)(?<next>.*)/
      |> Regex.named_captures(string)

    {to_rep, remaining} = String.split_at(next, String.to_integer(len))

    decompressed = [String.duplicate(to_rep, String.to_integer(rep))|decompressed]
    do_scan_for_markers(remaining, decompressed)
  end
end
