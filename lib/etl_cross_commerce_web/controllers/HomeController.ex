defmodule EtlCrossCommerceWeb.HomeController do
  @moduledoc """
    The function of this module is, Web controller from v1 API
  """
  use EtlCrossCommerceWeb, :controller

  alias EtlCrossCommerce.Main

  @doc """
    Index URL exemple: "http://localhost:4000/api/v1?page=1"

    Index params ->
      page: integer
  """
  # get paginated response and apresent in screen, JSON format
  def index(conn, params) do
    page = Map.fetch(params, "page") |> handle_response(1)
    {page, _} = Integer.parse(page)

    Main.load("lists/ordened.txt", page)
    |> simplify_json(conn)
  end

  @doc """
    Create URL exemple: "http://localhost:4000/api/v1/create?path=extract"

    Create params ->
      path: string
      page: integer
  """
  # create, order and paginated one page in Oficcial Rest API
  def create(conn, params) do
    path = Map.fetch(params, "path") |> handle_response("")
    page = Map.fetch(params, "page") |> handle_response("")
    cond do
      page == "" ->
        "parameter page is empty"
        |> simplify_json(conn)

      integer(Integer.parse(page)) == false ->
        "parameter page is invalid"
        |> simplify_json(conn)

      path == "" ->
        "parameter path is null"
        |> simplify_json(conn)

      true ->
        {page, _} = Integer.parse(page)
        path = "lists/created/#{path}"

        Main.extract("#{path}.txt", page)
        Main.transform("#{path}.txt", "#{path}.txt")
        Main.load("#{path}.txt",1)
        |> simplify_json(conn)
    end
  end

  defp integer(:error), do: false
  defp integer({_, _}), do: true


  @doc """
    Index URL exemple: "http://localhost:4000/api/v1?page=1"

    Index params ->
      page: integer
  """
  # get paginated response and apresent in screen, JSON format
  def read(conn, params) do
    path = Map.fetch(params, "path") |> handle_response(1)
    path= "lists/created/#{path}.txt"

    Main.load(path, 1)
    |> simplify_json(conn)
  end

  def list(conn, _) do
    File.ls!("lists/created")
    |> simplify_json(conn)
  end

  # Invert conn and JSON content
  defp simplify_json(content, conn), do: json(conn, content)

  # Error tratament
  defp handle_response(:error, default), do: default
  defp handle_response({:ok, ""}, default), do: default

  # Reponse support
  defp handle_response({:ok, response}, _default), do: response
end
