defmodule Y2024.Day11 do
  use Solution

  def parse() do
    File.read!("inputs/y2024/day11.txt")
    |> String.split("\n")
    |> hd()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp even_digits?(num) do
    count = Integer.to_charlist(num) |> Enum.count()
    rem(count, 2) == 0
  end

  defp blink(stones, 0), do: length(stones)

  defp blink(stones, counter) do
    IO.write("Blink: #{75 - counter}\n")

    new_stones =
      Enum.map(stones, fn stone ->
        cond do
          stone == 0 ->
            1

          even_digits?(stone) ->
            stone = Integer.to_charlist(stone)
            parts = Enum.split(stone, round(length(stone) / 2)) |> Tuple.to_list()

            Enum.map(parts, fn part ->
              to_string(part) |> String.trim() |> String.to_integer()
            end)

          true ->
            stone * 2024
        end
      end)
      |> List.flatten()

    blink(new_stones, counter - 1)
  end

  def part1() do
    # parse()
    # |> blink(25)
  end

  def part2() do
    parse()
    |> blink(75)
  end
end
