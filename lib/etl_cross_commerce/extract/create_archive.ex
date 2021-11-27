defmodule EtlCrossCommerce.Extract.CreateArchive do
  # Write list in one arcgive
  def write_list(list, path) do
    if Enum.count(list) > 0 do
      list = Enum.join(list,"\n")
      File.write(path, list)
    else
      {:error, "the list is empty"}
    end
  end

end
