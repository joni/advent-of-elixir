defmodule Day10 do
  def part1() do
    File.read!("input/day10.txt")
    |> bestAsteroidCount()
  end

  def bestAsteroidCount(input) do
    asteroids = parseInput(input)

    Enum.map(asteroids, fn pos ->
      countVisible(pos, asteroids)
    end)
    |> Enum.max()
  end

  defp parseInput(input) do
    String.split(input, "\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {el, idx} ->
      String.to_charlist(el)
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) == ?#))
      |> Enum.map(&{idx, elem(&1, 1)})
    end)
  end

  def countVisible(p = {px, py}, asteroids) do
    asteroids
    |> Enum.filter(&(&1 != p))
    |> Enum.map(fn {ax, ay} ->
      {ax - px, ay - py}
    end)
    |> Enum.uniq_by(&reduce/1)
    |> Enum.count()
  end

  def reduce({a, b}) do
    d = gcd(abs(a), abs(b))
    {div(a, d), div(b, d)}
  end

  defp gcd(a, b) do
    if b == 0 do
      a
    else
      gcd(b, rem(a, b))
    end
  end

  def part2() do
    File.read!("input/day10.txt")
    |> nthVaporized(200)
  end

  def nthVaporized(input, n) do
    {y, x} =
      vaporize(input)
      |> Enum.at(n - 1)

    100 * x + y
  end

  def vaporize(input) do
    asteroids = parseInput(input)

    station =
      {px, py} =
      Enum.max_by(asteroids, fn pos ->
        countVisible(pos, asteroids)
      end)

    Enum.filter(asteroids, &(&1 != station))
    |> Enum.group_by(fn {ax, ay} -> reduce({ax - px, ay - py}) end)
    |> asteroidsInOrder(station)
  end

  def asteroidsInOrder(grouped, station) do
    # TODO implement "continued rotation"
    Map.keys(grouped)
    |> Enum.sort_by(fn {x, y} ->
      -:math.atan2(y, x)
    end)
    |> Enum.map(fn key ->
      Map.get(grouped, key)
      |> Enum.min_by(&distance(station, &1))
    end)
  end

  defp distance({ax, ay}, {bx, by}) do
    abs(bx - ax) + abs(by - ay)
  end
end
