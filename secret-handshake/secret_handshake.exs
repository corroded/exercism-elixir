defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when (code &&& 0b10000) == 16 do
    commands(code - 16) |> Enum.reverse
  end
  def commands(code) do
    Integer.digits(code, 2) |> Enum.reverse |> check_bits([], 5)
  end

  def check_bits(bit_array, new_array, n) when n == 0 do
    new_array
  end

  def check_bits(bit_array, new_array, n) when bit_array == [] do
    new_array
  end

  def check_bits(bit_array, new_array, n) when hd(bit_array) == 1 do
    result_array = new_array ++ [append_to_array(n)]
    check_bits(tl(bit_array), result_array, n-1)
  end

  def check_bits(bit_array, new_array, n) do
    check_bits(tl(bit_array), new_array, n-1)
  end

  def append_to_array(n) when (n == 5) do
    "wink"
  end
  def append_to_array(n) when (n == 4) do
    "double blink"
  end
  def append_to_array(n) when (n == 3) do
    "close your eyes"
  end
  def append_to_array(n) when (n == 2) do
    "jump"
  end
  # def check_reverse(code) when (code &&& 0b10000 == 16) do
  #
  # end
end
