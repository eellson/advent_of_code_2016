defmodule AdventOfCode.Day10 do
  def run_a do
    "./lib/advent_of_code_2016/day_10/input.txt"
    |> File.read!
    |> lex()
    |> IO.inspect
    |> parse()
  end

  def lex(string), do: string |> String.to_charlist |> :bot_instruction_lexer.string

  def parse({:ok, tokens, _}) do
    {:ok, instructions} = :bot_instruction_parser.parse(tokens)
    instructions
  end
end
