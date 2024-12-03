defmodule Y2024.Day2 do
  use Solution

  def parse() do
    File.read!("inputs/y2024/day2.txt")
    |> String.split("\n")
    |> Enum.map(fn report ->
      String.split(report)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp is_safe(report) do
    inc = Enum.sort(report)
    dec = Enum.reverse(inc)
    diff = Enum.all?(diff(report), &Enum.member?(1..3, &1))

    (report == inc or report == dec) and diff
  end

  defp diff([]), do: []
  defp diff([_x | []]), do: []
  defp diff([x, y | tail]), do: [abs(x - y) | diff([y | tail])]

  def part1() do
    parse()
    |> Enum.count(&is_safe/1)
  end

  def part2() do
    parse()
    |> Enum.count(fn report ->
      max_index = Enum.count(report) - 1

      Enum.map(0..max_index, &(List.delete_at(report, &1) |> is_safe()))
      |> Enum.any?()
    end)
  end
end
