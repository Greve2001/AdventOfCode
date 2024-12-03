defmodule Y2024.Day3 do
  use Solution

  def parse() do
    File.read!("inputs/y2024/day3.txt")
    |> String.split("", trim: true)
    |> concat_numbers()
  end

  defp concat_numbers([]), do: []
  defp concat_numbers([x | []]), do: [x]

  defp concat_numbers([x, y | mem]) do
    case Integer.parse(x) do
      :error ->
        [x | concat_numbers([y | mem])]

      _ ->
        case Integer.parse(y) do
          :error ->
            [x | concat_numbers([y | mem])]

          _ ->
            concat_numbers([x <> y | mem])
        end
    end
  end

  defp scan([], acc), do: acc

  defp scan(["m", "u", "l", "(", x, ",", y, ")" | mem], acc),
    do: scan(mem, acc + String.to_integer(x) * String.to_integer(y))

  defp scan([_x | xs], acc), do: scan(xs, acc)

  def part1() do
    parse()
    |> scan(0)
  end

  defp scan_conditional(mem, acc, allow?)
  defp scan_conditional([], acc, _), do: acc

  defp scan_conditional(["d", "o", "(", ")" | mem], acc, _),
    do: scan_conditional(mem, acc, true)

  defp scan_conditional(["d", "o", "n", "'", "t", "(", ")" | mem], acc, _),
    do: scan_conditional(mem, acc, false)

  defp scan_conditional(["m", "u", "l", "(", x, ",", y, ")" | mem], acc, allow?) do
    case allow? do
      true -> scan_conditional(mem, acc + String.to_integer(x) * String.to_integer(y), allow?)
      false -> scan_conditional(mem, acc, allow?)
    end
  end

  defp scan_conditional([_x | xs], acc, allow?), do: scan_conditional(xs, acc, allow?)

  def part2() do
    parse()
    |> scan_conditional(0, true)
  end
end
