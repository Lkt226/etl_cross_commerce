defmodule EtlCrossCommerce.Extract.CreateArchive do
  @moduledoc """
    The function of this module is, write one archive in whatever path
  """

  @doc """
    write_list/2 ->

      ## Exemple
        write_list([1,2,3], "list/my_list.txt")

        return in archive "my_list.txt":
        1
        2
        3

      ## Exemple 2
      write_list([], "list/my_list_2.txt")

      return {:error, "the list is empty"}
  """

  def write_list(list, path) do
    if Enum.count(list) > 0 do
      list = Enum.join(list,"\n")
      File.write(path, list)
    else
      {:error, "the list is empty"}
    end
  end

end
