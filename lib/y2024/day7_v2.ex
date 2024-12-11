defmodule Y2024.Day7_V2 do
  alias Y2024.Day7_V2
  use Solution

  def parse() do
    File.read!("inputs/y2024/day7.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      [result, numbers] = String.split(row, ":", trim: true)

      result = String.to_integer(result)

      numbers =
        String.split(numbers, " ", trim: true)
        |> Enum.map(&String.to_integer/1)

      {result, numbers}
    end)
  end

  defp calibrate1([result], expected), do: result == expected

  defp calibrate1([n1, n2 | ns], expected) do
    cond do
      calibrate1([n1 + n2 | ns], expected) -> true
      calibrate1([n1 * n2 | ns], expected) -> true
      true -> false
    end
  end

  def part1() do
    parse()
    |> Enum.map(fn {result, numbers} -> {calibrate1(numbers, result), result} end)
    |> Enum.filter(fn {possible, _} -> possible end)
    |> Enum.reduce(0, fn {_, result}, acc -> result + acc end)
  end

  defp calibrate2([result], expected), do: result == expected

  defp calibrate2([n1, n2 | ns], expected) do
    cond do
      calibrate2([n1 + n2 | ns], expected) -> true
      calibrate2([n1 * n2 | ns], expected) -> true
      calibrate2([String.to_integer("#{n1}#{n2}") | ns], expected) -> true
      true -> false
    end
  end

  def part2() do
    parse()
    |> Enum.map(fn {result, numbers} -> {calibrate2(numbers, result), result} end)
    |> Enum.filter(fn {possible, _} -> possible end)
    |> Enum.reduce(0, fn {_, result}, acc -> result + acc end)
  end
end
