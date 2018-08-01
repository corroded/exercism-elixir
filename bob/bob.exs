defmodule Bob do
  def hey(input) do
    upcase? = fn x -> x == String.upcase(x) && String.match?(x, ~r/\p{Lu}/u) end

    cond do
      String.match?(input, ~r/^\s*$/) ->
        "Fine. Be that way!"
      upcase?.(input) ->
        cond do
          String.ends_with?(input, "?") ->
            "Calm down, I know what I'm doing!"
          true ->
            "Whoa, chill out!"
        end
      String.ends_with?(input, "?") ->
        "Sure."
      true -> "Whatever."
    end
  end
end
