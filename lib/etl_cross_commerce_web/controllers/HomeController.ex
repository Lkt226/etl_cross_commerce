defmodule EtlCrossCommerceWeb.HomeController do
  use EtlCrossCommerceWeb, :controller

  alias EtlCrossCommerce.Main

  def index(conn, params) do
    page = Map.fetch(params, "page") |> handle_response(1)
    {page, _} = Integer.parse(page)

    Main.load("lists/ordened.txt", page)
    |> simplify_json(conn)
  end

  def create(conn, params) do
    path = Map.fetch(params, "path") |> handle_response(1)
    path = "#{path}-#{Date.utc_today()}"
    path = "created/#{path}"

    Main.extract("#{path}.txt")
    Main.transform("#{path}.txt", "#{path}-ordened.txt")
    Main.load("#{path}.txt",1)
    |> simplify_json(conn)
  end

  defp simplify_json(content, conn), do: json(conn, content)

  # Error tratament
  defp handle_response(:error, default), do: default
  defp handle_response({:ok, ""}, default), do: default

  # Reponse
  defp handle_response({:ok, response}, _default), do: response
end
