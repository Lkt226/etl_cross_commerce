defmodule EtlCrossCommerce.Extract.ApiConsumeTest do
  use ExUnit.Case, async: true

  alias EtlCrossCommerce.Extract.ApiConsume

  describe "get_one_page/1" do
    test "get one page in api, and translate this data in one list, return [0.4181707133672159, ...]" do
      page = 1

      response =  ApiConsume.get_one_page(page)
      [head | _] = response
      expected_response = 0.4181707133672159

      assert head == expected_response
    end
  end

  test "get one page in api, but this page dont have numbers, return []" do
    page = 999999999

    response =  ApiConsume.get_one_page(page)

    expected_response = []

    assert response == expected_response
  end
end
