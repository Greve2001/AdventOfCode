defmodule Solution do
  @callback parse :: any()
  @callback part1 :: any()
  @callback part2 :: any()

  defmacro __using__(_opts) do
    quote do
      @behaviour Solution

      def run() do
        {p1_time, p1_res} = :timer.tc(fn -> part1() end)
        {p2_time, p2_res} = :timer.tc(fn -> part2() end)

        p1_time = Float.round(p1_time / 1000, 2)
        p2_time = Float.round(p2_time / 1000, 2)

        IO.write("Part 1 - (#{p1_time}ms): \t #{to_string(p1_res)}\n")
        IO.write("Part 2 - (#{p2_time}ms): \t #{to_string(p2_res)}\n")
      end
    end
  end
end
