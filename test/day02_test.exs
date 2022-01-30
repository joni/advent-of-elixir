defmodule Day02.Test do
  use ExUnit.Case, async: true

  test "Opcode 1 is add" do
    prog = Arrays.new([1, 0, 0, 0, 99])
    prog = Day02.run(prog)
    assert prog == Arrays.new([2, 0, 0, 0, 99])
  end

  test "Opcode 2 is multiply" do
    prog = Arrays.new([2, 3, 0, 3, 99])
    prog = Day02.run(prog)
    assert prog == Arrays.new([2, 3, 0, 6, 99])
  end

  test "Example program" do
    prog = Arrays.new([1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50])
    prog = Day02.run(prog)
    assert prog == Arrays.new([3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50])
  end

  test "Part 1" do
    assert Day02.part1() == 9_581_917
  end

  test "Part 2" do
    assert Day02.part2() == 2505
  end
end
