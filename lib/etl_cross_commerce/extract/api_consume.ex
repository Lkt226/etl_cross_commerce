defmodule EtlCrossCommerce.Extract.ApiConsume do
  @moduledoc """
    The function of this module is, consume pages in API Rest:
      'http://challenge.dienekes.com.br/api/numbers?page={page}
  """

  @doc """
    get_one_page/1 ->           |   call ->   get_one_page(1)
      get_one_page_private/2    |   return -> {"numbers":[0.10180, 0.0011918, 0.8601891]}
      decode_json/1             |   return -> [0.10180, 0.0011918, 0.8601891]
  """
  # fetch whatever page in API Rest, but only one.
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

  @doc """
    get_all_pages/0 ->          |   call ->   get_one_page()
      get_one_page_private/1    |   return -> {"numbers":[0.10180, 0.0011918, 0.8601891]}
      decode_json/1             |   return -> [0.10180, 0.0011918, 0.8601891]
      get_all_pages/2           |   return -> [0.10180, 0.0011918, 0.8601891, 0.5119188, 0.1179621, ...]
  """
  # fetch alls page in API Rest.
  def get_all_pages do
      get_one_page_private(1)
      |> decode_json()
      |> get_all_pages(2)
  end

  # repeat get_one_page_private/1 in all pages from API Rest
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

  # decode Json in one list
  defp decode_json(json), do: if %{"numbers" => content} = Poison.decode!(json), do: content

  # print in console, the error and execute one action.
  defp handle_error(code, message, action) do
    IO.write("#{code}: #{message} \n")
    Process.sleep(5)
    action
  end
end
