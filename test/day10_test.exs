defmodule Day10.Test do
  use ExUnit.Case, async: true

  test "Part 1 Example 1" do
    input = """
    .#..#
    .....
    #####
    ....#
    ...##
    """

    assert Day10.bestAsteroidCount(input) == 8
  end

  test "Part 1 Example 2" do
    input = """
    ......#.#.
    #..#.#....
    ..#######.
    .#.#.###..
    .#..#.....
    ..#....#.#
    #..#....#.
    .##.#..###
    ##...#..#.
    .#....####
    """

    assert Day10.bestAsteroidCount(input) == 33
  end

  test "Part 1 Example 3" do
    input = """
    .#..##.###...#######
    ##.############..##.
    .#.######.########.#
    .###.#######.####.#.
    #####.##.#.##.###.##
    ..#####..#.#########
    ####################
    #.####....###.#.#.##
    ##.#################
    #####.##.###..####..
    ..######..##.#######
    ####.##.####...##..#
    .#####..#.######.###
    ##...#.##########...
    #.##########.#######
    .####.#.###.###.#.##
    ....##.##.###..#####
    .#.#.###########.###
    #.#.#.#####.####.###
    ###.##.####.##.#..##
    """

    assert Day10.bestAsteroidCount(input) == 210
  end

  test "Part 1" do
    assert Day10.part1() == 253
  end

  test "Part 2 vaporize order" do
    input = """
    .#....#####...#..
    ##...##.#####..##
    ##...#...#.#####.
    ..#.....#...###..
    ..#.#.....#....##
    """

    assert Enum.take(Day10.vaporize(input), 10) == [
             {1, 8},
             {0, 9},
             {1, 9},
             {0, 10},
             {2, 9},
             {1, 11},
             {1, 12},
             {2, 11},
             {1, 15},
             {2, 12}
           ]
  end

  test "Part 2 vaporize order 2" do
    input = """
    .#..##.###...#######
    ##.############..##.
    .#.######.########.#
    .###.#######.####.#.
    #####.##.#.##.###.##
    ..#####..#.#########
    ####################
    #.####....###.#.#.##
    ##.#################
    #####.##.###..####..
    ..######..##.#######
    ####.##.####...##..#
    .#####..#.######.###
    ##...#.##########...
    #.##########.#######
    .####.#.###.###.#.##
    ....##.##.###..#####
    .#.#.###########.###
    #.#.#.#####.####.###
    ###.##.####.##.#..##
    """

    assert Day10.nthVaporized(input, 10) == 1208
    assert Day10.nthVaporized(input, 200) == 802
  end

  test "Part 2" do
    assert Day10.part2() == 815
  end
end
