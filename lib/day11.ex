defmodule Day11 do
  def part1() do
    File.read!("input/day11.txt")
    |> Day09.new_program()
    |> run
  end

  def part2() do
    File.read!("input/day11.txt")
    |> Day09.new_program()
    |> run2
  end

  def run(program) do
    child = spawn_link(Day09, :run, [program, self()])
    send(child, 0)

    doLoop(child, %{}, {0, 0}, :up)
    |> map_size()
  end

  def run2(program) do
    child = spawn_link(Day09, :run, [program, self()])
    send(child, 1)

    doLoop(child, %{{0, 0} => 1}, {0, 0}, :up)
    |> print_hull
  end

  defp doLoop(robot_pid, panels, pos, dir) do
    # IO.puts("#{inspect(pos)} #{inspect(dir)}")

    receive do
      :end ->
        panels

      color ->
        panels = Map.put(panels, pos, color)

        receive do
          turn ->
            # IO.puts("#{color} #{turn}")
            dir = new_dir(dir, turn)
            pos = new_pos(dir, pos)
            send(robot_pid, Map.get(panels, pos, 0))
            doLoop(robot_pid, panels, pos, dir)
        end
    end
  end

  defp print_hull(panels) do
    {minx, maxx} =
      Map.keys(panels)
      |> Enum.map(&elem(&1, 0))
      |> Enum.min_max()

    {miny, maxy} =
      Map.keys(panels)
      |> Enum.map(&elem(&1, 1))
      |> Enum.min_max()

    for y <- maxy..miny do
      for x <- minx..maxx do
        case Map.get(panels, {x, y}, 0) do
          0 -> ?.
          1 -> ?#
        end
      end
      |> List.to_string()
    end
    |> Enum.join("\n")
  end

  defp new_dir(:up, 0), do: :left
  defp new_dir(:right, 0), do: :up
  defp new_dir(:down, 0), do: :right
  defp new_dir(:left, 0), do: :down

  defp new_dir(:up, 1), do: :right
  defp new_dir(:right, 1), do: :down
  defp new_dir(:down, 1), do: :left
  defp new_dir(:left, 1), do: :up

  defp new_pos(:up, {x, y}), do: {x, y + 1}
  defp new_pos(:right, {x, y}), do: {x + 1, y}
  defp new_pos(:down, {x, y}), do: {x, y - 1}
  defp new_pos(:left, {x, y}), do: {x - 1, y}
end
