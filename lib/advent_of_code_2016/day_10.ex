defmodule AdventOfCode.Day10 do
  alias AdventOfCode.Day10.Bot

  def run_a do
    "./lib/advent_of_code_2016/day_10/input.txt"
    |> File.read!()
    |> lex()
    |> parse()
    |> Enum.each(&exec/1)
  end

  def exec(value: value, to: bot), do: give(bot, value: value)
  def exec(bot: bot, instruction: instruction) do
    give(bot, instruction: instruction)
  end

  def give(name, thing) do
    Bot.give(name, thing)
  end

  defp lex(string) do
    string |> String.to_charlist() |> :bot_instruction_lexer.string()
  end

  defp parse({:ok, tokens, _}) do
    {:ok, instructions} = :bot_instruction_parser.parse(tokens)
    instructions
  end
end
