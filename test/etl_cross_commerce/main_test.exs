defmodule EtlCrossCommerce.MainTest do
  use ExUnit.Case, async: true

  alias EtlCrossCommerce.Main

  describe "extract/2" do
    test "Extract one page and create the archive, return :ok" do
      path = "test/archives/test-main-1.txt"
      page = 1

      response = Main.extract(path, page)

      expected_response = :ok

      assert response == expected_response
    end

    test "Extract one page and create the archive, but a page is empty, return {:error, 'this list is empty'}" do
      path = "test/archives/test-main-2.txt"
      page = 9999999999

      response = Main.extract(path, page)

      expected_response = {:error, "the list is empty"}

      assert response == expected_response
    end
  end

  describe "transform/2" do
    test "Read, order and create new archive, full ordened itens, return :ok" do
      old_path = "test/archives/test-main-1.txt"
      new_path = "test/archives/test-main-2.txt"

      response = Main.transform(old_path, new_path)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "load/2" do
    test "Read and paginate the list, the size is 200 per page, return [0.011586609375527822,...]" do
      path = "test/archives/test-main-2.txt"
      page = 1

      response = Main.load(path, page)
      [head | _] = response

      expected_response = "0.011586609375527822"

      assert head == expected_response
    end

    test "Read page 99999 in the list, and return []" do
      path = "test/archives/test-main-2.txt"
      page = 99999

      response = Main.load(path, page)

      expected_response = []

      assert response == expected_response
    end
  end
end
