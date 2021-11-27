defmodule EtlCrossCommerce.Load.PaginateTest do
  use ExUnit.Case, async: true

  alias EtlCrossCommerce.Load.Paginate

  describe "call/3" do
    test "Paginate one list, in custom size, Return [6, 7 ,8, ...] " do
      list = [1, 2, 3, 4, 5, 6, 7 ,8 ,9 ,10]
      size = 5
      page = 2

      response = Paginate.call(list, size, page)

      expected_response = [6, 7 ,8 ,9 ,10]

      assert response == expected_response
    end

    test "Paginate one list, in 5 size, but the list have only 4 itens Return only [1,2,3,4] " do
      list = [1, 2, 3, 4]
      size = 5
      page = 1

      response = Paginate.call(list, size, page)

      expected_response = [1,2,3,4]

      assert response == expected_response
    end

    test "If enter in one page, but the list have finish, return [] " do
      list = [1, 2, 3, 4, 5]
      size = 5
      page = 3

      response = Paginate.call(list, size, page)

      expected_response = []

      assert response == expected_response
    end

    test "If pass negative page or 0, search by last page, return error([6, 7, 8, 9, 10])" do
      list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      size = 5
      page = 0

      response = Paginate.call(list, size, page)

      expected_response = [6, 7, 8, 9, 10]

      assert response == expected_response
    end
  end

end
