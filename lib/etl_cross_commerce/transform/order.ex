defmodule EtlCrossCommerce.Transform.Order do
  # Call Ordener
  def order(old_list), do: min_and_max(old_list, [], [])

  defp min_and_max(old_list, min, max) do
    cond do
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
  # Support defs
  defp delete_item_in_list(item, list), do: list -- [item]

  defp add_item_in_list(item, list), do: list ++ [item]

end
