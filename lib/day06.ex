defmodule Day06 do
  def countOrbits(input) do
    orbits =
      String.split(input, "\n", trim: true)
      |> Enum.map(fn line ->
        parts = String.split(line, ")")
        {Enum.at(parts, 1), Enum.at(parts, 0)}
      end)
      |> Map.new()

    Enum.reduce(Map.keys(orbits), %{"COM" => 0}, fn object, orbitCount ->
      countOrbitsForObject(orbits, orbitCount, object)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def countOrbitsForObject(orbits, orbitCount, object) do
    if Map.has_key?(orbitCount, object) do
      orbitCount
    else
      parent = orbits[object]
      orbitCount = countOrbitsForObject(orbits, orbitCount, parent)
      Map.put(orbitCount, object, orbitCount[parent] + 1)
    end
  end

  def part1() do
    File.read!("input/day06.txt")
    |> countOrbits()
  end

  def countTransfers(input) do
    orbits =
      String.split(input, "\n", trim: true)
      |> Enum.map(fn line ->
        parts = String.split(line, ")")
        {Enum.at(parts, 1), Enum.at(parts, 0)}
      end)
      |> Map.new()

    youPath = parents(orbits, "YOU") |> Enum.reverse()
    sanPath = parents(orbits, "SAN") |> Enum.reverse()
    {youRest, sanRest} = dropCommonPrefix(youPath, sanPath)

    length(youRest) + length(sanRest) - 2
  end

  def parents(orbits, object) do
    if Map.has_key?(orbits, object) do
      [object | parents(orbits, orbits[object])]
    else
      [object]
    end
  end

  def dropCommonPrefix(xs, ys) do
    [x | xrest] = xs
    [y | yrest] = ys

    if x == y do
      dropCommonPrefix(xrest, yrest)
    else
      {xs, ys}
    end
  end

  def part2() do
    File.read!("input/day06.txt")
    |> countTransfers()
  end
end
