defmodule AdventOfCode.Day10.Output do
  def start_link, do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def put(key, value), do: Agent.update(__MODULE__, &Map.put(&1, key, value))
end
