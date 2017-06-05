defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(<<text::binary-size(1)>>, shift) do
    text |> String.to_charlist
         |> List.first
         |> compute(shift)
         |> List.wrap
         |> List.to_string
  end
  def rotate(<<head::binary-size(1), tail::binary>>, shift) do
    kek = head |> String.to_charlist
         |> List.first
         |> compute(shift)

    [kek, rotate(tail, shift)] |> List.to_string
  end

  def compute(num, shift) when ((num >= ?a) and (num <= ?z) and (num+shift) > ?z) or
                               ((num >= ?A) and (num <= ?Z) and (num+shift) > ?Z) do
    (num + shift) |> Kernel.-(26) |> Kernel.abs
  end
  def compute(num, shift) when num == ?\s or (num <= ?9) do
    num
  end
  def compute(num, shift) do
    num + shift
  end
end

