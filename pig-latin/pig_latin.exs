defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    words = String.split(phrase, " ")
    cond do
      Enum.count(words) > 1 ->
        Enum.map(words, fn(x) -> translate(x) end) |> Enum.join(" ")
      String.starts_with?(phrase, ["a", "e", "i", "o", "u"]) ->
        "#{phrase}ay"
      Enum.any?(Regex.scan(~r/^[xy]{1}[^aeiou]/, phrase)) ->
        "#{phrase}ay"
      captures = Regex.named_captures(~r/(?<cons>[^aeiou]?qu)(?<rest>\w*)/, phrase) ->
        "#{captures["rest"]}#{captures["cons"]}ay"
      true ->
        translate "#{String.slice(phrase, 1..-1)}#{String.at(phrase, 0)}"
    end
  end
end
