defmodule Y2024.Day4_V2 do
  use Solution

  def parse() do
    File.read!("inputs/y2024/day4.txt")
    |> String.split("\n", trim: true)
  end

  defp check_xmas(grid, x, y, dx, dy, acc \\ "") do
    word = "XMAS"

    in_bound? =
      String.length(acc) < String.length(word) &&
        y < length(grid) &&
        x >= 0 &&
        x < String.length(Enum.at(grid, y))

    cond do
      acc == word or acc == String.reverse(word) ->
        1

      # Just for performace
      in_bound? and String.length(acc) == 0 and
          !Enum.member?(["X", "S"], String.at(Enum.at(grid, y), x)) ->
        0

      in_bound? ->
        next_char = String.at(Enum.at(grid, y), x)
        check_xmas(grid, x + dx, y + dy, dx, dy, acc <> next_char)

      true ->
        0
    end
  end

  defp check_mas(grid, x, y, dx, dy, acc \\ "") do
    word = "MAS"

    in_bound? =
      String.length(acc) < String.length(word) &&
        y < length(grid) &&
        x >= 0 &&
        x < String.length(Enum.at(grid, y))

    cond do
      acc == word or acc == String.reverse(word) ->
        1

      # Just for performace
      in_bound? and String.length(acc) == 0 and
          !Enum.member?(["M", "S"], String.at(Enum.at(grid, y), x)) ->
        0

      String.length(acc) < String.length(word) and y < length(grid) and x >= 0 and
          x < String.length(Enum.at(grid, y)) ->
        next_char = String.at(Enum.at(grid, y), x)
        check_mas(grid, x + dx, y + dy, dx, dy, acc <> next_char)

      true ->
        0
    end
  end

  def part1() do
    grid = parse()

    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      String.split(row, "", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {_, x} ->
        [
          check_xmas(grid, x, y, 0, 1),
          check_xmas(grid, x, y, 1, 0),
          check_xmas(grid, x, y, 1, 1),
          check_xmas(grid, x, y, -1, 1)
        ]
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2() do
    grid = parse()

    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      String.split(row, "", trim: true)
      |> Enum.with_index()
      |> Enum.count(fn {_, x} ->
        check_mas(grid, x, y, 1, 1) == 1 and check_mas(grid, x, y + 2, 1, -1) == 1
      end)
    end)
    |> Enum.sum()
  end
end
