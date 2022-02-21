defmodule Day08 do
  def part1() do
    File.read!("input/day08.txt")
    |> String.trim()
    |> splitLayers(25 * 6)
    |> Enum.min_by(&countZeros/1)
    |> check
  end

  defp splitLayers(input, len) do
    if String.length(input) <= len do
      [input]
    else
      {layer, rest} = String.split_at(input, len)
      [layer | splitLayers(rest, len)]
    end
  end

  defp countZeros(layer) do
    String.to_charlist(layer)
    |> Enum.count(&(&1 == ?0))
  end

  defp check(layer) do
    cl = String.to_charlist(layer)
    Enum.count(cl, &(&1 == ?1)) * Enum.count(cl, &(&1 == ?2))
  end

  def part2() do
    layers =
      File.read!("input/day08.txt")
      |> String.trim()
      |> splitLayers(25 * 6)

    for row <- 0..5 do
      for col <- 0..24 do
        Enum.map(layers, &String.at(&1, row * 25 + col))
        |> Enum.find(&(&1 != "2"))
      end
      |> Enum.join("")
    end
    |> Enum.join("\n")
    |> String.replace("0", ".")
    |> String.replace("1", "#")
    # |> IO.write
  end
end
