defmodule Y2024.Day11_V2 do
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

  defp add_stone(stones, key, val) do
    Map.put(stones, key, Map.get(stones, key, 0) + val)
  end

  defp blink(stones, 0),
    do: Map.to_list(stones) |> Enum.reduce(0, fn {_key, val}, acc -> val + acc end)

  defp blink(stones, counter) do
    Enum.reduce(Map.keys(stones), Map.new(), fn stone_key, new_stones ->
      stone_val = Map.get(stones, stone_key, 0)

      cond do
        stone_key == 0 ->
          add_stone(new_stones, 1, stone_val)

        even_digits?(stone_key) ->
          stone_key = Integer.to_charlist(stone_key)
          parts = Enum.split(stone_key, round(length(stone_key) / 2)) |> Tuple.to_list()

          new_stone_vals =
            Enum.map(parts, fn part ->
              to_string(part) |> String.trim() |> String.to_integer()
            end)

          new_stones
          |> add_stone(Enum.at(new_stone_vals, 0), stone_val)
          |> add_stone(Enum.at(new_stone_vals, 1), stone_val)

        true ->
          add_stone(new_stones, stone_key * 2024, stone_val)
      end
    end)
    |> blink(counter - 1)
  end

  def part1() do
    nums = parse()

    stones =
      Enum.reduce(nums, Map.new(), fn num, acc ->
        add_stone(acc, num, 1)
      end)

    blink(stones, 25)
  end

  def part2() do
    nums = parse()

    stones =
      Enum.reduce(nums, Map.new(), fn num, acc ->
        add_stone(acc, num, 1)
      end)

    blink(stones, 75)
  end
end
