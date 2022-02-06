defmodule Day06.Test do
  use ExUnit.Case, async: true

  test "Part 1 Example" do
    example = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    """

    assert Day06.countOrbits(example) == 42
  end

  test "Part 1" do
    assert Day06.part1() == 292_387
  end

  test "Part 2 Example" do
    example = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    K)YOU
    I)SAN
    """

    assert Day06.countTransfers(example) == 4
  end

  test "Part 2" do
    assert Day06.part2() == 433
  end
end
