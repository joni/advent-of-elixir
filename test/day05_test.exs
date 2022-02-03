defmodule Day05.Test do
  use ExUnit.Case, async: true

  @compare_to_8 "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"

  test "Echo program" do
    prog = Arrays.new([3, 0, 4, 0, 99])
    output = Day05.run(prog, [123])
    assert output == [123]
  end

  test "Multiply" do
    prog = Arrays.new([1002, 4, 3, 4, 33])
    output = Day05.run(prog, [])
    assert output == []
  end

  test "Part 1" do
    output = Day05.part1()
    assert output == 16_225_258
  end

  test "Less than 8" do
    prog = Day05.new_program(@compare_to_8)
    assert Day05.run(prog, [7]) == [999]
  end

  test "Equal to 8" do
    prog = Day05.new_program(@compare_to_8)
    assert Day05.run(prog, [8]) == [1000]
  end

  test "Greater than 8" do
    prog = Day05.new_program(@compare_to_8)
    assert Day05.run(prog, [9]) == [1001]
  end

  test "Part 2" do
    output = Day05.part2()
    assert output == 2_808_771
  end
end
