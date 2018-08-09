defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    split_codons = Regex.scan(~r/[A-Z]{3}/, rna) |> List.flatten
    translated_codons = Enum.take_while(translate_codons(split_codons), fn(x) -> x != "STOP" end)
    cond do
      Enum.any?(translated_codons, fn(x) -> x == "invalid codon" end) ->
        {:error, "invalid RNA"}
      Enum.empty?(translated_codons) ->
        {:error, "invalid RNA"}
      true ->
        {:ok, translated_codons}
    end
  end

  defp translate_codons(codon_chain) do
    Enum.map(codon_chain, fn(x) ->
      case of_codon(x) do
        {:error, _} ->
          "invalid codon"
        {:ok, codon} ->
          codon
        _ ->
          "invalid codon"
      end
    end)
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """

  @codons %{
    "UGU": "Cysteine",
    "UGC": "Cysteine",
    "UUA": "Leucine",
    "UUG": "Leucine",
    "AUG": "Methionine",
    "UUU": "Phenylalanine",
    "UUC": "Phenylalanine",
    "UCU": "Serine",
    "UCC": "Serine",
    "UCA": "Serine",
    "UCG": "Serine",
    "UGG": "Tryptophan",
    "UAU": "Tyrosine",
    "UAC": "Tyrosine",
    "UAA": "STOP",
    "UAG": "STOP",
    "UGA": "STOP",
  }

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case new_codon = @codons[String.to_atom(codon)] do
      nil ->
        {:error, "invalid codon"}
      _ ->
        {:ok, new_codon}
    end
  end
end
