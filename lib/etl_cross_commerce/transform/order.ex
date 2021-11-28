defmodule EtlCrossCommerce.Transform.Order do
  @moduledoc """
    The function of this module is, order my extracted list
  """

  @doc """
    order/1 ->              |  call ->    order([1,3,5,4,2])
      min_and_max/3         |  return ->  [1,2,3,4,5]
  """
  # call ordener, min_and_max/3
  def order(old_list), do: min_and_max(old_list, [], [])

  # 1. get max number and min number in my list
  # 2. create two diferences lists for min and max
  # 3. delete max and min numbers in my old_list
  # 4. repeat while my old_list contain zero itens
  # 5. revert max list and join min and max lists
  defp min_and_max(old_list, min, max) do
    cond do
      is_list(old_list) == false ->
        "error: the list is invalid"

      Enum.count(old_list) > 1 ->
      item_min = Enum.min(old_list)
      item_max = Enum.max(old_list)

      min = add_item_in_list(item_min, min)
      max = add_item_in_list(item_max, max)

      old_list = delete_item_in_list(item_min, old_list)
      old_list = delete_item_in_list(item_max, old_list)

      IO.write("#{Enum.count(old_list)}\n")
      min_and_max(old_list, min, max)

      Enum.count(old_list) == 1 ->
        item_min = Enum.min(old_list)

        min = add_item_in_list(item_min, min)

        old_list = delete_item_in_list(item_min, old_list)

        IO.write("#{Enum.count(old_list)}\n")
        min_and_max(old_list, min, max)

      true ->
        min ++ Enum.reverse(max)
    end
  end

  # delete one item in whatever list
  defp delete_item_in_list(item, list), do: list -- [item]
  # add one item in whatever list
  defp add_item_in_list(item, list), do: list ++ [item]

end
