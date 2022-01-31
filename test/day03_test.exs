defmodule Day03.Test do
  use ExUnit.Case, async: true

  test "Part 1 Example 0" do
    input = """
    R8,U5,L5,D3
    U7,R6,D4,L4
    """

    assert Day03.solve(input) == 6
  end

  test "Part 1 Example 1" do
    input = """
    R75,D30,R83,U83,L12,D49,R71,U7,L72
    U62,R66,U55,R34,D71,R55,D58,R83
    """

    assert Day03.solve(input) == 159
  end

  test "Part 1 Example 2" do
    input = """
    R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
    U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
    """

    assert Day03.solve(input) == 135
  end

  test "Part 1" do
    assert Day03.part1() == 1264
  end

  test "Part 2 Example 0" do
    input = """
    R8,U5,L5,D3
    U7,R6,D4,L4
    """

    assert Day03.solve2(input) == 30
  end

  test "Part 2 Example 1" do
    input = """
    R75,D30,R83,U83,L12,D49,R71,U7,L72
    U62,R66,U55,R34,D71,R55,D58,R83
    """

    assert Day03.solve2(input) == 610
  end

  test "Part 2 Example 2" do
    input = """
    R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
    U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
    """

    assert Day03.solve2(input) == 410
  end

  test "Part 2" do
    assert Day03.part2() == 37390
  end
end
