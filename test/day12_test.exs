defmodule Day12.Test do
  use ExUnit.Case, async: true

  test "Step 1" do
    zero = {0, 0, 0}
    state = [{{-1, 0, 2}, zero}, {{2, -10, -7}, zero}, {{4, -8, 8}, zero}, {{3, 5, -1}, zero}]

    assert Day12.step(state) == [
             {{2, -1, 1}, {3, -1, -1}},
             {{3, -7, -4}, {1, 3, 3}},
             {{1, -7, 5}, {-3, 1, -3}},
             {{2, 2, 0}, {-1, -3, 1}}
           ]
  end

  test "Energy after 10 steps" do
    zero = {0, 0, 0}
    state = [{{-1, 0, 2}, zero}, {{2, -10, -7}, zero}, {{4, -8, 8}, zero}, {{3, 5, -1}, zero}]
    assert Day12.energy(Day12.doSteps(state, 10)) == 179
  end

  test "Energy after 100 steps" do
    zero = {0, 0, 0}
    state = [{{-8, -10, 0}, zero}, {{5, 5, 10}, zero}, {{2, -7, 3}, zero}, {{9, -8, -3}, zero}]
    assert Day12.energy(Day12.doSteps(state, 100)) == 1940
  end

  test "Part 1" do
    zero = {0, 0, 0}
    state = [{{8,0,8}, zero}, {{0,-5,-10}, zero}, {{16,10,-5}, zero}, {{19,-10,-7}, zero}]
    assert Day12.energy(Day12.doSteps(state, 1000)) == 12490
  end

  test "Step dimension until same" do
    state = {[-1, 2, 4, 3], [0, 0, 0, 0]}
    assert Day12.stepDimensionUntilSame(state) == 18
  end

  test "Count until same state example 1" do
    zero = {0, 0, 0}
    state = [{{-1, 0, 2}, zero}, {{2, -10, -7}, zero}, {{4, -8, 8}, zero}, {{3, 5, -1}, zero}]
    assert Day12.countStepsUntilSame(state) == 2772
  end

  test "Count until same state example 2" do
    zero = {0, 0, 0}
    state= [{{-8, -10, 0}, zero}, {{5, 5, 10}, zero}, {{2, -7, 3}, zero}, {{9, -8, -3}, zero}]
    assert Day12.countStepsUntilSame(state) == 4686774924
  end

  test "Part 2" do
    zero = {0, 0, 0}
    state = [{{8,0,8}, zero}, {{0,-5,-10}, zero}, {{16,10,-5}, zero}, {{19,-10,-7}, zero}]
    assert Day12.countStepsUntilSame(state) == 392733896255168
  end
end
