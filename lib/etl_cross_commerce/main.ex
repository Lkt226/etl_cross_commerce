defmodule EtlCrossCommerce.Main do
  @moduledoc """
    The function of this module is, is call others scripts in my application
  """

  alias EtlCrossCommerce.Transform.{Order, ReadArchive}
  alias EtlCrossCommerce.Extract.{CreateArchive, ApiConsume}
  alias EtlCrossCommerce.Load.{Paginate}

  # extract/2 -> Extract one page and create one archive with content
  def extract(path, page) do
    ApiConsume.get_one_page(page)
    |> CreateArchive.write_list(path)
  end

  # extract/1 -> Extract all pages and create one archive with content
  def extract(path) do
    ApiConsume.get_all_pages()
    |> CreateArchive.write_list(path)
  end

  # transform/2 -> Read, Ordener one old archive, and create a new archive with content
  def transform(path, new_path) do
    path
    |> ReadArchive.read_list()
    |> Order.order()
    |> CreateArchive.write_list(new_path)
  end

  # load/2 -> Read the ordened archive, and return one list paginated with content
  def load(path, page) do
    path
    |> ReadArchive.read_list()
    |> handle_load(page)
  end

  #handle load, to resolver one error
  defp handle_load(list, page) do
    if is_list(list) == true do
      Paginate.call(list ,200, page)
    else
      list
    end
  end
end
