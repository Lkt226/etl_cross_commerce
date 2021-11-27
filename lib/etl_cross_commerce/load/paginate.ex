defmodule EtlCrossCommerce.Load.Paginate do

  def call(list, size, page) do
    item_id = size * (page - 1)
    max_size = size * page

    split_in_pages([], item_id, list, max_size)
  end

  defp split_in_pages(new_list, item_id, list, max_size) do
    if item_id < max_size do
      enum_item = Enum.at(list, item_id) |> is_nil?()

      if enum_item != "" do
        new_list
        |> Enum.concat(enum_item)
        |> split_in_pages(item_id+1, list, max_size)
      else
        new_list
      end
    else
      new_list
    end
  end

  defp is_nil?(value), do: if value == nil, do: "", else: [value]
end
