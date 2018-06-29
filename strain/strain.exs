defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep([], fun), do: []
  def keep(list, fun) do
    all_true? = list |> Enum.all?(&(fun.(&1)))

    if all_true? do
      list
    else
      index = list |> Enum.find_index(&(!fun.(&1)))
      if index do
        list |> List.delete_at(index) |> keep(fun)
      end
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  # @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  # def discard(list, fun) do
  # end
end
