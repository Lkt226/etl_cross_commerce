defmodule EtlCrossCommerce.Main do
  alias EtlCrossCommerce.Transform.{Order, ReadArchive}
  alias EtlCrossCommerce.Extract.{CreateArchive, ApiConsume}
  alias EtlCrossCommerce.Load.{Paginate}

  def extract(path, page) do
    ApiConsume.get_one_page(page)
    |> CreateArchive.write_list(path)
  end

  def extract(path) do
    ApiConsume.get_all_pages()
    |> CreateArchive.write_list(path)
  end

  def transform(path, new_path) do
    path
    |> ReadArchive.read_list()
    |> Order.order()
    |> CreateArchive.write_list(new_path)
  end

  def load(path, page) do
    path
    |> ReadArchive.read_list()
    |> Paginate.call(200, page)
  end
end
