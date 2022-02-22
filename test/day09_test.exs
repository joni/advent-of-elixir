defmodule Day09.Test do
  use ExUnit.Case, async: true

  test "Part 1 Example 1" do
    program = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"

    assert Day09.run(program) == [
             109,
             1,
             204,
             -1,
             1001,
             100,
             1,
             100,
             1008,
             100,
             16,
             101,
             1006,
             101,
             0,
             99
           ]
  end

  test "Part 1 Example 2" do
    program = "1102,34915192,34915192,7,4,7,99,0"
    assert Day09.run(program) == [1_219_070_632_396_864]
  end

  test "Part 1 Example 3" do
    program = "104,1125899906842624,99"
    assert Day09.run(program) == [1_125_899_906_842_624]
  end

  test "Part 1" do
    assert Day09.part1() == [4234906522]
  end

  test "Part 2" do
    assert Day09.part2() == [60962]
  end
end
