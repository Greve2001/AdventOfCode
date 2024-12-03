defmodule Y2024.Day1 do
  use Solution

  def parse() do
    File.read!("inputs/y2024/day1.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [x, y] = String.split(line) |> Enum.map(&String.to_integer/1)
      {x, y}
    end)
    |> Enum.unzip()
  end

  def part1() do
    Tuple.to_list(parse())
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip_with(fn [x, y] -> abs(x - y) end)
    |> Enum.sum()
  end

  def part2() do
    {list1, list2} = parse()

    Enum.map(list1, fn x ->
      count = Enum.count(list2, fn y -> x == y end)
      count * x
    end)
    |> Enum.sum()
  end
end
