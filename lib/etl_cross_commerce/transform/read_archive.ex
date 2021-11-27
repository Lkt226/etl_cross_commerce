defmodule EtlCrossCommerce.Transform.ReadArchive do
  def read_list(path, patt) do
    {:ok, list } = File.read(path)

    list
    |> String.split(patt)
  end

  def read_list(path) do
    {:ok, list } = File.read(path)

    list
    |> String.split("\n")
  end
end
