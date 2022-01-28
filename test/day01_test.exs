defmodule Day01.Test do
  use ExUnit.Case, async: true

  test "Part1 Example" do
    assert Day01.fuel_req(12) == 2
    assert Day01.fuel_req(14) == 2
    assert Day01.fuel_req(1969) == 654
    assert Day01.fuel_req(100_756) == 33583
  end

  test "Part1" do
    assert Day01.part1() == 3_511_949
  end

  test "Part2 Example" do
    assert Day01.rec_fuel_req(14) == 2
    assert Day01.rec_fuel_req(1969) == 966
    assert Day01.rec_fuel_req(100_756) == 50346
  end

  test "Part2" do
    assert Day01.part2() == 5_265_045
  end
end
