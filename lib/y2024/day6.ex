defmodule Y2024.Day6 do
  use Solution

  def parse() do
    File.read!("inputs/y2024/day6.txt")
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      String.split(row, "", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {pos, x} ->
        val =
          case pos do
            "#" -> :wall
            "^" -> {:guard, :up}
            "." -> []
          end

        {{x, y}, val}
      end)
    end)
  end

  def part1() do
    grid = parse()

    guard =
      find_guard(grid)
      |> dbg()

    to_array(grid)

    nil
  end

  def part2() do
  end

  defp to_array(grid),
    do:
      grid
      |> Enum.map(&List.to_tuple/1)
      |> List.to_tuple()

  defp add_path(path_walked, {x, y}, dir) do
    key = String.to_atom("x#{x}y#{y}")

    case Map.get(path_walked, key, nil) do
      nil -> Map.put(path_walked, key, [dir])
      older_pos -> Map.put(path_walked, key, [dir | older_pos])
    end
  end

  defp find_guard(grid) do
    {pos, {_, dir}} =
      Enum.find(grid, nil, fn row ->
        Enum.find(row, nil, fn {_pos, type} ->
          case type do
            {:guard, _} -> true
            _ -> false
          end
        end)
      end)
      |> Enum.find(fn {_pos, type} ->
        case type do
          {:guard, _} -> true
          _ -> false
        end
      end)

    {pos, dir}
  end

  defp traverse(grid, {{x, y}, dir}, path_walked) do
    new_pos =
      case dir do
        :up -> at(grid, {x, y - 1})
      end
  end

  defp at(grid, {x, y}),
    do:
      grid
      |> elem(y)
      |> elem(x)

  defp turn(:up), do: :right
  defp turn(:right), do: :down
  defp turn(:down), do: :left
  defp turn(:left), do: :up
end
