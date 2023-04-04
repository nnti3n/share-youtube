require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "name" do
    assert_equal "Nnti3n", users(:nnti3n).name
  end
end
