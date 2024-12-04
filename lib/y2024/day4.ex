defmodule Y2024.Day4 do
  use Solution

  def parse() do
    File.read!("inputs/y2024/day4.txt")
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {line, y} ->
      String.split(line, "", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {letter, x} ->
        {letter, {x, y}}
      end)
    end)
    |> List.flatten()
  end

  defp categorize_letters([], acc), do: acc

  defp categorize_letters([{"X", coord} | ls], {xs, ms, as, ss}),
    do: categorize_letters(ls, {[coord | xs], ms, as, ss})

  defp categorize_letters([{"M", coord} | ls], {xs, ms, as, ss}),
    do: categorize_letters(ls, {xs, [coord | ms], as, ss})

  defp categorize_letters([{"A", coord} | ls], {xs, ms, as, ss}),
    do: categorize_letters(ls, {xs, ms, [coord | as], ss})

  defp categorize_letters([{"S", coord} | ls], {xs, ms, as, ss}),
    do: categorize_letters(ls, {xs, ms, as, [coord | ss]})

  defp adjacent_direction({x1, y1}, {x2, y2}) do
    cond do
      x1 - x2 == -1 and y1 - y2 == -1 -> :dr
      x1 - x2 == -1 and y1 - y2 == 1 -> :ur
      x1 - x2 == 1 and y1 - y2 == -1 -> :dl
      x1 - x2 == 1 and y1 - y2 == 1 -> :ul
      x1 - x2 == -1 and y1 == y2 -> :r
      x1 - x2 == 1 and y1 == y2 -> :l
      y1 - y2 == -1 and x1 == x2 -> :d
      y1 - y2 == 1 and x1 == x2 -> :u
      true -> nil
    end
  end

  defp find_adjacent_letter(letter_coords, current_coord) do
    Enum.map(letter_coords, fn coord ->
      adjacent_direction(current_coord, coord)
    end)
    |> Enum.filter(&(&1 != nil))
  end

  defp has_coord?(coords, coord) do
    case Enum.find_index(coords, &(&1 == coord)) do
      nil -> false
      _ -> true
    end
  end

  def part1() do
    {xs, ms, as, ss} =
      parse()
      |> categorize_letters({[], [], [], []})

    # Find adjacent M's'
    Enum.map(xs, fn x ->
      {x, find_adjacent_letter(ms, x)}
    end)
    |> Enum.map(fn {{x, y}, dirs} ->
      Enum.count(dirs, fn dir ->
        case dir do
          :u -> has_coord?(as, {x, y - 2}) and has_coord?(ss, {x, y - 3})
          :d -> has_coord?(as, {x, y + 2}) and has_coord?(ss, {x, y + 3})
          :l -> has_coord?(as, {x - 2, y}) and has_coord?(ss, {x - 3, y})
          :r -> has_coord?(as, {x + 2, y}) and has_coord?(ss, {x + 3, y})
          :ul -> has_coord?(as, {x - 2, y - 2}) and has_coord?(ss, {x - 3, y - 3})
          :dl -> has_coord?(as, {x - 2, y + 2}) and has_coord?(ss, {x - 3, y + 3})
          :ur -> has_coord?(as, {x + 2, y - 2}) and has_coord?(ss, {x + 3, y - 3})
          :dr -> has_coord?(as, {x + 2, y + 2}) and has_coord?(ss, {x + 3, y + 3})
        end
      end)
    end)
    |> Enum.sum()
  end

  def part2() do
    {_, ms, as, ss} =
      parse()
      |> categorize_letters({[], [], [], []})

    Enum.count(as, fn {x, y} ->
      first_diagonal? =
        (has_coord?(ms, {x - 1, y - 1}) and has_coord?(ss, {x + 1, y + 1})) or
          (has_coord?(ss, {x - 1, y - 1}) and has_coord?(ms, {x + 1, y + 1}))

      second_diagonal? =
        (has_coord?(ms, {x - 1, y + 1}) and has_coord?(ss, {x + 1, y - 1})) or
          (has_coord?(ss, {x - 1, y + 1}) and has_coord?(ms, {x + 1, y - 1}))

      first_diagonal? and second_diagonal?
    end)
  end
end
