defmodule Y2023.Day3 do
  use Solution

  def parse() do
    lists =
      File.read!("inputs/y2023/day3.txt")
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.map(fn {line, y} ->
        val = String.split(line, "", trim: true)
        {val, y}
      end)
      |> Enum.map(fn {str_list, y} ->
        nums = identify_numbers(str_list, 0, y, nil, [])
        parts = identify_parts(str_list, 0, y, [])

        {parts, nums}
      end)

    {parts, nums} = Enum.unzip(lists)
    {List.flatten(parts), List.flatten(nums)}

    # dbg(parts)
    # dbg(nums)
  end

  defp identify_numbers(str_list, x, y, tmp, acc)

  defp identify_numbers([], x, y, tmp, acc) do
    case tmp do
      nil -> acc
      {num, i1, _i2} -> [{String.to_integer(num), i1, x - 1, y} | acc]
    end
  end

  defp identify_numbers([val | tail], x, y, tmp, acc) do
    char_val = String.to_charlist(val) |> hd()

    case Enum.member?(48..57, char_val) do
      false ->
        case tmp do
          nil ->
            identify_numbers(tail, x + 1, y, nil, acc)

          {num, i1, _i2} ->
            identify_numbers(tail, x + 1, y, nil, [{String.to_integer(num), i1, x - 1, y} | acc])
        end

      true ->
        case tmp do
          nil ->
            identify_numbers(tail, x + 1, y, {"#{val}", x, nil}, acc)

          {num, i1, i2} ->
            identify_numbers(tail, x + 1, y, {num <> "#{val}", i1, i2}, acc)
        end
    end
  end

  defp identify_parts([], _, _, acc), do: acc

  defp identify_parts([symbol | tail], x, y, acc) do
    case Enum.member?(String.to_charlist("@*#-+&/%=$"), String.to_charlist(symbol) |> hd()) do
      true -> identify_parts(tail, x + 1, y, [{x, y} | acc])
      false -> identify_parts(tail, x + 1, y, acc)
    end
  end

  defp is_adjacent(x1, y1, x2, y2) do
    x? = abs(x1 - x2) <= 1
    y? = abs(y1 - y2) <= 1

    x? and y?
  end

  defp is_number_adjacent({_num, x1, x2, y}, {px, py}) do
    Enum.any?(x1..x2, &is_adjacent(&1, y, px, py))
  end

  def part1() do
    {parts, nums} = parse()

    Enum.map(parts, fn part ->
      Enum.filter(nums, &is_number_adjacent(&1, part))
      |> Enum.map(fn {num, _x1, _x2, _y} -> num end)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  def part2() do
    {parts, nums} = parse()

    Enum.map(parts, fn part ->
      Enum.filter(nums, &is_number_adjacent(&1, part))
      |> Enum.map(fn {num, _x1, _x2, _y} -> num end)
    end)
    |> Enum.filter(fn nums -> Enum.count(nums) == 2 end)
    |> Enum.map(fn [num1, num2] -> num1 * num2 end)
    |> Enum.sum()
  end
end
