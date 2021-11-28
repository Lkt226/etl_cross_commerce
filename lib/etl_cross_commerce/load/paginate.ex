defmodule EtlCrossCommerce.Load.Paginate do

  @moduledoc """
    The function of this module is, paginate the large list,
    multiples small lists with size is custom
  """

  @doc """
    call/3 ->                     |  call ->    call([1,2,3,4,5,6], 3, 2)
      split_in_pages/4            |  return ->  [4,5,6]
  """
  # create min and max size and call split_in_pages/4
  def call(list, size, page) do
    item_id = size * (page - 1)
    max_size = size * page

    split_in_pages([], item_id, list, max_size)
  end

  # create a new list, contained only custom size
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

  # Consume enum_item, and if value is null return "", else return value in one list ([value])
  defp is_nil?(value), do: if value == nil, do: "", else: [value]
end
