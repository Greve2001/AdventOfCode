defmodule Solution do
  @callback parse :: any()
  @callback part1 :: any()
  @callback part2 :: any()

  defmacro __using__(_opts) do
    quote do
      @behaviour Solution

      def run() do
        IO.write("Part 1: " <> to_string(part1()) <> "\n")
        IO.write("Part 2: " <> to_string(part2()) <> "\n")
      end
    end
  end
end
