defmodule Day1Part2 do
  def calibrate() do
    File.stream!("input/day_1.txt")
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(0, fn line, acc ->
      acc + extract_number(line)
    end)
  end

  def extract_number(line) do
    line
    |> String.split("")
    |> Enum.reduce({[], []}, fn char, {a, b} ->
      case Integer.parse(char) do
        {num, _} -> {[num | a], []}

        _ -> spell_number(b ++ [char], a)
      end
    end)
    |> assemble_number
  end

  defp assemble_number({a, _b}) do
    [last | _] = a
    [first | _] = Enum.reverse(a)
    String.to_integer("#{first}#{last}")
  end


def spell_number(list, a) do
  i = case String.downcase(List.to_string(list)) do
    ~r/.*\bone\b.*/ -> 1
    ~r/.*\btwo\b.*/ -> 2
    ~r/.*\bthree\b.*/ -> 3
    ~r/.*\bfour\b.*/ -> 4
    ~r/.*\bfive\b.*/ -> 5
    ~r/.*\bsix\b.*/ -> 6
    ~r/.*\bseven\b.*/ -> 7
    ~r/.*\beight\b.*/ -> 8
    ~r/.*\bnine\b.*/ -> 9
    _ -> 0
  end

  if i != 0 do
    {[i | a], []}
  else
    {a, list}
  end
end

end
