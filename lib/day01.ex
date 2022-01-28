defmodule Day01 do
  def fuel_req(mass) do
    floor(mass / 3) - 2
  end

  def rec_fuel_req(mass) do
    req = fuel_req(mass)

    if req < 0 do
      0
    else
      req + rec_fuel_req(req)
    end
  end

  def part1() do
    File.read!("input/day01.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&fuel_req/1)
    |> Enum.sum()
  end

  def part2() do
    File.read!("input/day01.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&rec_fuel_req/1)
    |> Enum.sum()
  end
end
