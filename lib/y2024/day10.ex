defmodule Y2024.Day10 do
  use Solution

  @dirs [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]

  def parse() do
    File.read!("inputs/y2024/day10.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, "", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp find_trailheads(trail) do
    Enum.with_index(trail)
    |> Enum.map(fn {row, y} ->
      Enum.with_index(row)
      |> Enum.map(fn {point, x} ->
        {point, x, y}
      end)
    end)
    |> List.flatten()
    |> Enum.filter(fn {point, _x, _y} -> point == 0 end)
    |> Enum.map(fn {_point, x, y} -> {x, y} end)
  end

  defp trail_to_tuple(trail) do
    Enum.map(trail, &List.to_tuple/1)
    |> List.to_tuple()
  end

  defp valid_adjacent_paths({x, y}, trail) do
    tmp = Tuple.to_list(trail)
    max_x = length(tmp)
    max_y = Tuple.to_list(hd(tmp)) |> length()

    curr_point =
      trail
      |> elem(y)
      |> elem(x)

    Enum.filter(@dirs, fn {dx, dy} ->
      cond do
        x + dx >= max_x ->
          false

        x + dx < 0 ->
          false

        y + dy >= max_y ->
          false

        y + dy < 0 ->
          false

        true ->
          adj_point =
            trail
            |> elem(y + dy)
            |> elem(x + dx)

          adj_point - curr_point == 1
      end
    end)
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
  end

  def part1() do
    trail_list = parse()

    trail =
      trail_to_tuple(trail_list)

    find_trailheads(trail_list)
    |> Enum.map(fn {x, y} ->
      nil
    end)

    nil
  end

  def part2() do
  end
end
