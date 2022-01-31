defmodule Day03 do
  def part1() do
    File.read!("input/day03.txt")
    |> solve
  end

  def solve(input) do
    String.split(input)
    |> Enum.map(&parseWire/1)
    |> intersections
    |> Enum.map(&manhattan/1)
    |> leastPositive
  end

  defp parseWire(line) do
    String.split(line, ",")
    |> traceWire
  end

  defp traceWire(wire) do
    Enum.flat_map_reduce(wire, {0, 0}, fn segment, last ->
      trace = traceSegment(last, segment)
      {trace, Enum.at(trace, -1)}
    end)
    |> elem(0)
    |> List.insert_at(0, {0, 0})
  end

  defp traceSegment({x, y}, segment) do
    <<direction>> <> digits = segment
    number = String.to_integer(digits)

    case direction do
      ?R -> for val <- 1..number, do: {x + val, y}
      ?L -> for val <- 1..number, do: {x - val, y}
      ?U -> for val <- 1..number, do: {x, y + val}
      ?D -> for val <- 1..number, do: {x, y - val}
    end
  end

  defp intersections([wire1, wire2]) do
    set1 = MapSet.new(wire1)
    set2 = MapSet.new(wire2)
    MapSet.intersection(set1, set2)
  end

  defp manhattan({x, y}) do
    abs(x) + abs(y)
  end

  def part2() do
    File.read!("input/day03.txt")
    |> solve2
  end

  def solve2(input) do
    wires =
      String.split(input)
      |> Enum.map(&parseWire/1)

    intersections(wires)
    |> Enum.map(&signalDelay(&1, wires))
    |> leastPositive
  end

  defp signalDelay(point, wires) do
    Enum.map(wires, fn wire ->
      Enum.find_index(wire, &(&1 == point))
    end)
    |> Enum.sum()
  end

  defp leastPositive(lst) do
    Enum.filter(lst, &(&1 > 0))
    |> Enum.min()
  end
end
