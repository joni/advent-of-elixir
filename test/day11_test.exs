defmodule Day11.Test do
  use ExUnit.Case, async: true

  test "Part 1" do
    assert Day11.part1() == 1771
  end

  test "Part 2" do
    output = """
    .#..#..##..####.#..#...##.#..#.#..#.####...
    .#..#.#..#.#....#..#....#.#..#.#..#....#...
    .####.#....###..####....#.####.#..#...#....
    .#..#.#.##.#....#..#....#.#..#.#..#..#.....
    .#..#.#..#.#....#..#.#..#.#..#.#..#.#......
    .#..#..###.####.#..#..##..#..#..##..####...\
    """

    assert Day11.part2() == output
  end
end
