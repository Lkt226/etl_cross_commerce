defmodule EtlCrossCommerce.Extract.ApiConsume do

  def get_one_page(page) do
    get_one_page_private(page)
    |> decode_json()
  end

  defp get_one_page_private(page) do
    url = "http://challenge.dienekes.com.br/api/numbers?page=#{page}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
      {:ok, %HTTPoison.Response{status_code: 404}} -> "Pagina não encontrada :('"

      {:ok, %HTTPoison.Response{status_code: 500, body: error}} ->
        handle_error(500, error, get_one_page_private(page))

      {:error, %HTTPoison.Error{reason: reason}} ->
        handle_error(reason, "Ocorreu um erro inesperado", get_one_page_private(page))
    end
  end

  # All pages
  def get_all_pages do
      get_one_page_private(1)
      |> decode_json()
      |> get_all_pages(2)
  end

  defp get_all_pages(list, current_page) do
    page = get_one_page_private(current_page)
    decode = decode_json(page)
    if decode != [] do
      Enum.concat(list, decode)
      |> get_all_pages(current_page+1)
    else
      list
    end
  end

  #Support Defs
  defp decode_json(json), do: if %{"numbers" => content} = Poison.decode!(json), do: content
  defp concat_list(item, list), do: Enum.concat(list, item)

  #Error Tratament
  defp handle_error(code, message) do
    IO.write("#{code}: #{message} \n")
  end

  defp handle_error(code, message, fun) do
    IO.write("#{code}: #{message} \n")
    Process.sleep(5)
    fun
  end
end
