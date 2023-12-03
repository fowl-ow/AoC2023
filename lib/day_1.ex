defmodule Day1 do
  def calibrate() do
    File.stream!("input/day_1.txt")
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(0, fn line, acc ->
      acc + extract_number(line)
    end)
  end

  def extract_number(string) do
    list = String.split(string, "")
    first_number = extract_first_number(list)
    last_number = extract_last_number(list)

    case {first_number, last_number} do
      {nil, _} -> 0
      {f, l} -> String.to_integer("#{f}#{l}")
    end
  end

  def extract_first_number([]), do: nil

  def extract_first_number([h | t]) do
    case Integer.parse(h) do
      {int, _} -> int
      _ -> extract_first_number(t)
    end
  end

  def extract_last_number(list) do
    list
    |> Enum.reverse()
    |> extract_first_number
  end
end
