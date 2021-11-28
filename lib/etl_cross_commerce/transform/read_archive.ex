defmodule EtlCrossCommerce.Transform.ReadArchive do
  @moduledoc """
    The function of this module is, read whatever archive, and transform he in list
  """

  @doc """
  ## Exemple1                   |  "archive.txt" => "1-2-3-4-5-6"
    read_list/2 ->              |  call ->    read_list("archive.txt","-")
      String.split/1            |  return ->  [1,2,3,4,5,6]

  ## Exemple2                   |  "archive2.txt" => "1\n 2\n 3\n 4\n 5\n 6"
    read_list/1 ->              |  call ->    read_list("archive2.txt")
      String.split/1            |  return ->  [1,2,3,4,5,6]
  """
  # read one archive and transform he in one list based in custom pattern
  def read_list(path, patt) do
    File.read(path)
    |> handle_response()
    |> String.split(patt)
  end

  # read one archive and transform he in one list based in "\n" pattern
  def read_list(path) do
    File.read(path)
    |> handle_response()
    |> String.split("\n")
  end

  defp handle_response({:ok, list}), do: list
  defp handle_response({:error, error}), do: IO.write(error)

end
