defmodule Y2024.Day5 do
  use Solution

  def parse() do
    [order_rules, updates] =
      File.read!("inputs/y2024/day5.txt")
      |> String.split("\n\n")

    order_rules =
      String.split(order_rules, "\n", trim: true)
      |> Enum.map(fn rule ->
        String.split(rule, "|", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    updates =
      String.split(updates, "\n", trim: true)
      |> Enum.map(fn update ->
        String.split(update, ",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    [order_rules, updates]
  end

  defp breaks_rule?(update, checked, order_rules)
  defp breaks_rule?([], _, _), do: true

  defp breaks_rule?([u | us], checked, order_rules) do
    relevant_rules =
      Enum.filter(order_rules, fn [first, _] -> first == u end)
      |> Enum.map(fn [_first, last] -> last end)

    breaks_rule? = Enum.any?(relevant_rules, &Enum.member?(checked, &1))

    case breaks_rule? do
      false -> breaks_rule?(us, [u | checked], order_rules)
      true -> false
    end
  end

  defp get_middle(update) do
    Enum.at(update, Integer.floor_div(Enum.count(update), 2))
  end

  def part1() do
    [order_rules, updates] = parse()

    Enum.map(updates, fn update ->
      case breaks_rule?(update, [], order_rules) do
        false -> 0
        true -> get_middle(update)
      end
    end)
    |> Enum.sum()
  end

  defp correct_update([u | us], corrected, order_rules) do
  end

  def part2() do
    [order_rules, updates] = parse()

    Enum.map(updates, fn update ->
      correct_update(update, [], order_rules)
    end)
  end
end
