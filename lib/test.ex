defmodule NumberExtractor do
  def get_number(input) do
    charlist = String.to_charlist(input)
    first_number = extract_first_number(charlist)
    last_number = extract_last_number(charlist)
    assembled_string = assemble_string(first_number, last_number)
    String.to_integer(assembled_string)
  end

  defp extract_first_number([]), do: nil
  defp extract_first_number([h | t]) when is_number(h), do: h
  defp extract_first_number([_ | t]), do: extract_first_number(t)

  defp extract_last_number(charlist) do
    reversed = Enum.reverse(charlist)
    extract_first_number(reversed)
  end

  defp assemble_string(nil, _), do: ""
  defp assemble_string(_, nil), do: ""
  defp assemble_string(first, last), do: "#{first}#{last}"
end

