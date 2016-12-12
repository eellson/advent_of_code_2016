defmodule AdventOfCode.Day10.Bot do
  alias AdventOfCode.Day10.{Bot, Output}

  use GenServer

  defstruct values: [], instructions: [], name: nil

  # Client

  def start_link(name: name), do: GenServer.start_link(__MODULE__, name, name: name)

  def give({:output, n}, value: value) do
    Output.start_link
    Output.put(n, value)
  end
  def give(name, thing) do
    Bot.start_link(name: name)
    GenServer.call(name, thing)
  end
  def give(name, instruction: instruction) do
    Bot.start_link(name: name)
    GenServer.call(name, {:store_instruction, instruction})
  end

  def check(name), do: GenServer.call(name, :state)

  # Server

  def init(name), do: {:ok, %Bot{name: name}}

  def handle_call([value: value], _from, bot) do
    bot = Map.update!(bot, :values, &([value | &1])) |> execute_instruction()
    {:reply, bot, bot}
  end
  def handle_call([instruction: instruction], _from, bot) do
    bot = Map.update!(bot, :instructions, &([instruction | &1])) |> execute_instruction()
    {:reply, bot, bot}
  end

  def execute_instruction(%Bot{instructions: instructions} = bot) when length(instructions) < 1, do: bot
  def execute_instruction(%Bot{values: values} = bot) when length(values) < 2, do: bot
  def execute_instruction(%Bot{values: values, instructions: instructions} = bot) do
    instruction = instructions |> Enum.reverse |> Enum.at(0)
    values = values |> Enum.sort
    {low_value, high_value} = {Enum.at(values, 0), Enum.at(values, -1)}

    if match?({^low_value, ^high_value}, {17, 61}), do: IO.inspect bot

    give(instruction[:low], value: low_value)
    give(instruction[:high], value: high_value)

    Map.put(bot, :values, List.delete(values, low_value) |> List.delete(high_value))
  end

  def handle_call(:state, from, bot), do: {:reply, bot, bot}
end
