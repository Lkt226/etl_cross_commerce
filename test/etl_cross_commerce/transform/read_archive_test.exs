defmodule EtlCrossCommerce.Transform.ReadArchiveTest do
  use ExUnit.Case, async: true

  alias EtlCrossCommerce.Transform.ReadArchive

  describe "read_list/1" do
    test "Read one archive txt, idented from \n, Return [1,2,3,4,5] strings" do
      path = "test/archives/test-read_archive-1.txt"

      response = ReadArchive.read_list(path)

      expected_response = ["1","2","3","4","5"]

      assert response == expected_response
    end

    test "Read one archive txt, but it was indented wrong, Return (['1,2,3,4,5']) one string in all list" do
      path = "test/archives/test-read_archive-2.txt"

      response = ReadArchive.read_list(path)

      expected_response = ["1, 2, 3, 4, 5"]

      assert response == expected_response
    end

    test "Try read one archive, but not exist" do
      path = "test/archives/v1/test-read_archive.txt"

      response = ReadArchive.read_list(path)

      expected_response = "error: the archive not exist"

      assert response == expected_response
    end

  end

end
