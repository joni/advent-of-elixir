defmodule Day13 do
  def part1() do
    File.read!("input/day13.txt")
    |> Day09.new_program()
    |> run
  end

  def run(program) do
    child = spawn_link(Day09, :run, [program, self()])
    doLoop(child, %{})
    |> Map.values()
    |> Enum.filter(&(&1 == 2))
    |> length()
  end

  defp doLoop(robot_pid, panels) do
    receive do
      :end ->
        panels

      pos_x ->
        receive do
          pos_y ->
            receive do
              tile_id ->
                doLoop(robot_pid, Map.put(panels, {pos_x, pos_y}, tile_id))
            end
        end
    end
  end

  def part2() do
    File.read!("input/day13.txt")
    |> Day09.new_program()
    |> Arrays.replace(0, 2)
    |> run2
  end

  def run2(program) do
    child = spawn_link(Day09, :run, [program, self()])
    doLoop2(child, %{}, 0, 0, 0)
  end

  defp doLoop2(robot_pid, panels, ball_x, paddle_x, score) do
    receive do
      :end ->
        score

      pos_x ->
        receive do
          pos_y ->
            receive do
              tile_id ->
                paddle_x =
                  if tile_id == 3 do
                    pos_x
                  else
                    paddle_x
                  end

                ball_x =
                  if tile_id == 4 do
                    pos_x
                  else
                    ball_x
                  end

                score =
                  if pos_x == -1 do
                    tile_id
                  else
                    score
                  end

                doLoop2(
                  robot_pid,
                  Map.put(panels, {pos_x, pos_y}, tile_id),
                  ball_x,
                  paddle_x,
                  score
                )
            end
        end
    after
      10 ->
        # Hacky way to detect if waiting for input
        joystick =
          cond do
            ball_x < paddle_x -> -1
            ball_x > paddle_x -> +1
            true -> 0
          end

        send(robot_pid, joystick)
        doLoop2(robot_pid, panels, ball_x, paddle_x, score)
    end
  end
end
