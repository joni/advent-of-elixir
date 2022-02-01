defmodule Day04 do
  def input() do
    284_639..748_759
    |> Enum.map(&Integer.to_string/1)
  end

  def part1() do
    input()
    |> Enum.filter(&isValid/1)
    |> Enum.count()
  end

  def isValid(password) do
    twoAdjacentSame(password) && monotonic(password)
  end

  defp twoAdjacentSame(password) do
    case password do
      <<x, x>> <> _ -> true
      <<_>> <> rest -> twoAdjacentSame(rest)
      "" -> false
    end
  end

  defp monotonic(password) do
    case password do
      <<x, y>> <> rest -> x <= y && monotonic(<<y>> <> rest)
      _ -> true
    end
  end

  def part2() do
    input()
    |> Enum.filter(&isValid2/1)
    |> Enum.count()
  end

  def isValid2(password) do
    twoAdjacentSameButNotThree(password) && monotonic(password)
  end

  defp twoAdjacentSameButNotThree(password) do
    String.codepoints(password)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.any?(&(&1 == 2))
  end
end
