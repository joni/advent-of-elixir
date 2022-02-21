defmodule Day08.Test do
  use ExUnit.Case, async: true

  test "Part 1" do
    assert Day08.part1() == 2193
  end

  test "Part 2" do
    output = """
    #...#####.#..#.####.####.
    #...##....#..#.#....#....
    .#.#.###..####.###..###..
    ..#..#....#..#.#....#....
    ..#..#....#..#.#....#....
    ..#..####.#..#.####.#....\
    """
    assert Day08.part2() == output
  end
end
