defmodule Day12 do
  def doSteps(moons, 0) do
    moons
  end

  def doSteps(moons, count) do
    step(doSteps(moons, count - 1))
  end

  def energy(moons) do
    Enum.map(moons, fn {pos, vel} ->
      vector_energy(pos) * vector_energy(vel)
    end)
    |> Enum.sum()
  end

  def step(moons) do
    gravity =
      Enum.map(moons, fn {pos, _} ->
        for dim <- 0..2 do
          Enum.map(moons, fn {pos2, _} ->
            sign(elem(pos2, dim) - elem(pos, dim))
          end)
          |> Enum.sum()
        end
        |> List.to_tuple()
      end)

    Enum.zip_with(moons, gravity, fn {pos, vel}, gravity ->
      velocity = vector_sum(vel, gravity)
      position = vector_sum(pos, velocity)
      {position, velocity}
    end)
  end

  defp vector_energy({v1, v2, v3}) do
    abs(v1) + abs(v2) + abs(v3)
  end

  defp vector_sum({u1, u2, u3}, {v1, v2, v3}) do
    {u1 + v1, u2 + v2, u3 + v3}
  end

  defp vector_sum_list(u, v) do
    Enum.zip_with(u, v, &Kernel.+/2)
  end

  defp sign(n) do
    cond do
      n < 0 -> -1
      n == 0 -> 0
      n > 0 -> 1
    end
  end

  def stepDimension({pos, vel}) do
    gravity =
      Enum.map(pos, fn v ->
        Enum.map(pos, fn u ->
          sign(u - v)
        end)
        |> Enum.sum()
      end)

    velocity = vector_sum_list(vel, gravity)
    position = vector_sum_list(pos, velocity)

    {position, velocity}
  end

  def stepDimensionUntilSame(state) do
    Stream.iterate(state, &stepDimension/1)
    |> Stream.drop(1)
    |> Enum.find_index(&(&1 == state))
    |> (&(&1 + 1)).()
  end

  def countStepsUntilSame(moons) do
    for dim <- 0..2 do
      positions =
        Enum.map(moons, fn {pos, _} ->
          elem(pos, dim)
        end)

      velocities =
        Enum.map(moons, fn {_, vel} ->
          elem(vel, dim)
        end)

      stepDimensionUntilSame({positions, velocities})
    end
    |> lcm()
  end

  defp lcm(numbers) do
    Enum.reduce(numbers, &lcm/2)
  end

  defp lcm(a, b) do
    div(a * b, gcd(a, b))
  end

  defp gcd(a, b) do
    if b == 0 do
      a
    else
      gcd(b, rem(a, b))
    end
  end
end
