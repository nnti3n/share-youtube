require "test_helper"

class UserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  include Devise::Test::IntegrationHelpers

  test "allows user to sign up" do
    get new_user_registration_path
    assert_response :success

    assert_difference("User.count") do
      post user_registration_path,
           params: {
             user: {
               email: "user@example.com",
               password: "password",
               password_confirmation: "password",
             },
           }
    end

    assert_redirected_to root_path
    assert_equal "Welcome! You have signed up successfully.", flash[:notice]

    user = @controller.instance_variable_get(:@user)
    assert user.email == "user@example.com"
    assert user.valid_password?("password")
  end
end
