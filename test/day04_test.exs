defmodule Day04.Test do
  use ExUnit.Case, async: true

  test "Part 1 isValid" do
    assert Day04.isValid("111111")
    assert not Day04.isValid("223450")
    assert not Day04.isValid("123789")
  end

  test "Part 1" do
    assert Day04.part1() == 895
  end

  test "Part 2 isValid" do
    assert Day04.isValid2("112233")
    assert not Day04.isValid2("123444")
    assert Day04.isValid2("111122")
    assert not Day04.isValid2("111112")
  end

  test "Part 2" do
    assert Day04.part2() == 591
  end
end
