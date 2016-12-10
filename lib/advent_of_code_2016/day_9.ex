defmodule AdventOfCode.Day9 do
  def run_a do
    "./lib/advent_of_code_2016/day_9/input.txt"
    |> File.read!()
    |> decompress()
    |> String.length
  end

  def decompress(string) do
    string
    |> scan_for_markers()
  end

  def scan_for_markers(string), do: do_scan_for_markers(string, [])

  def do_scan_for_markers("", decompressed) do
    decompressed
    |> Enum.reverse
    |> Enum.join
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

    do_scan_for_markers(remaining, [String.duplicate(to_rep, String.to_integer(rep))|decompressed])
  end
end
