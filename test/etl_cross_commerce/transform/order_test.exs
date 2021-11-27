defmodule EtlCrossCommerce.Transform.OrderTest do
  use ExUnit.Case, async: true

  alias EtlCrossCommerce.Transform.Order

  describe "order/1" do
    test "Order itens from minor to major, return [1,2,3,4,5]" do
      old_list = [5,3,2,4,1]

      response = Order.order(old_list)

      expected_response = [1,2,3,4,5]

      assert response == expected_response
    end

    test "if pass one tuple and not list, return error" do
      old_list = {5,3,2,4,1}

      assert_raise(Protocol.UndefinedError, fn  ->
        Order.order(old_list)
      end)
    end
  end
end
