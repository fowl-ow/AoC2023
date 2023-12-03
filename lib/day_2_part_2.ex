defmodule Day2Part2 do
  def run do
    File.stream!("input/day_2.txt")
    |> Stream.map(&String.trim/1)
    |> Enum.map(fn line ->
      id = 
        Regex.run(~r/Game (\d+):/, line, capture: :all_but_first)
        |> List.to_string
        |> String.to_integer

      x =
        Regex.replace(~r/^Game \d+: /, line, "")
        |> String.split("; ", trim: true)
        |> Enum.map(fn y ->
          String.split(y, ", ", trim: true)
          |> Enum.map(fn z ->
            [count, color] = Regex.run(~r/(\d+) (\w+)/, z, capture: :all_but_first)
            {String.to_integer(count), color}
          end)
        end)

      {id, x}
    end)
    |> Enum.reduce(0, fn {_id, x}, acc ->
      {r, g, b} = Enum.reduce(x, {0, 0, 0}, fn elem, {red, green, blue} ->
        {x, _} = Enum.find(elem, fn {_, color} -> color == "red" end) || {0, "red"}
        {y, _} = Enum.find(elem, fn {_, color} -> color == "green" end) || {0, "green"}
        {z, _} = Enum.find(elem, fn {_, color} -> color == "blue" end) || {0, "blue"}
        r = if x > red, do: x, else: red
        g = if y > green, do: y, else: green
        b = if z > blue, do: z, else: blue
        {r, g, b}
      end)
      acc + (r * g * b)
    end)
  end
end
