defmodule EtlCrossCommerce.Extract.CreateArchiveTest do
  use ExUnit.Case, async: true

  alias EtlCrossCommerce.Extract.CreateArchive

  describe "write_list/2" do
    test "Write one archive based in one list, splitted by '\n', return :ok" do
      list = [1, 2, 3, 4, 5]
      path = "test/archives/test-create_archive-1.txt"

      response = CreateArchive.write_list(list, path)

      expected_response = :ok

      assert response == expected_response
    end

    test "Try write one archive based in one list, but i not passed list" do
      list = 1
      path = "test/archives/v1/test-create_archive-1.txt"

      response = CreateArchive.write_list(list, path)

      expected_response = "error: the list is invalid"

      assert response == expected_response
    end

    test "Try write one archive based in one list, but folder not exist" do
      list = [1, 2, 3, 4, 5]
      path = "test/archives/v1/test-create_archive-1.txt"

      response = CreateArchive.write_list(list, path)

      expected_response = "error: the path is invalid"

      assert response == expected_response
    end
  end
end
