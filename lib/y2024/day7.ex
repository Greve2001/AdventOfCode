defmodule Y2024.Day7 do
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

  defp permutate_operators(_operators, 0), do: [[]]

  defp permutate_operators(operators, length) do
    for element <- operators,
        tail <- permutate_operators(operators, length - 1),
        do: [element | tail]
  end

  defp calibrate([result], _), do: [result]
  defp calibrate(numbers, []), do: numbers

  defp calibrate([n1, n2 | ns], [o | os]) do
    res =
      case o do
        :+ -> n1 + n2
        :* -> n1 * n2
        :|| -> String.to_integer("#{n1}#{n2}")
      end

    calibrate([res | ns], os)
  end

  def part1() do
    parse()
    |> Enum.filter(fn {result, numbers} ->
      permutate_operators([:+, :*], Enum.count(numbers) - 1)
      |> Enum.map(fn permutation ->
        calibrate(numbers, permutation)
      end)
      |> Enum.any?(&(&1 == [result]))
    end)
    |> Enum.reduce(0, fn {result, _}, acc -> acc + result end)
  end

  def part2() do
    parse()
    |> Enum.filter(fn {result, numbers} ->
      permutate_operators([:+, :*, :||], Enum.count(numbers) - 1)
      |> Enum.map(fn permutation ->
        calibrate(numbers, permutation)
      end)
      |> Enum.any?(&(&1 == [result]))
    end)
    |> Enum.reduce(0, fn {result, _}, acc -> acc + result end)
  end
end
