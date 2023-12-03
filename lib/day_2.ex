defmodule Day2 do
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
    |> Enum.reduce(0, fn {id, x}, acc ->
      if Enum.any?(x, fn elem ->
        Enum.any?(elem, fn z ->
          case z do
            {count, "red"} when count > 12 -> 
              true
            {count, "green"} when count > 13 -> 
              true
            {count, "blue"} when count > 14 -> 
              true
            _ -> false
          end
        end)
      end) do
        acc
      else
        acc + id
      end
    end)

    # |> Enum.reduce(0, fn line, acc -> acc + line end)
  end
end
