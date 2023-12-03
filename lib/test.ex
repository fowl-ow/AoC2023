defmodule Test do
  def cal do
    pattern = ~r/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/

    File.stream!("input/day_1.txt")
    |> Stream.map(fn line ->
      matches =
        Regex.scan(pattern, line, capture: :all_but_first)
        |> List.flatten()
        |> Enum.map(fn
          "one" -> "1"
          "two" -> "2"
          "three" -> "3"
          "four" -> "4"
          "five" -> "5"
          "six" -> "6"
          "seven" -> "7"
          "eight" -> "8"
          "nine" -> "9"
          input -> input
        end)

      first = List.first(matches)
      last = List.last(matches)

      String.to_integer(first <> last)
    end)
    |> Enum.sum()
  end
end
