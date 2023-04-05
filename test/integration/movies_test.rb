require "test_helper"

class MoviesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  include Devise::Test::IntegrationHelpers

  setup { sign_in users(:nnti3n) }

  test "redirect if not signed in" do
    sign_out :user

    get "/movies"
    assert_response :redirect
  end

  test "can get movies" do
    get "/movies"
    assert_response :success
  end

  test "can get share" do
    get "/share"
    assert_response :success
  end

  test "can share a new movie" do
    post "/create",
         params: {
           url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
         }

    get "/movies"
    assert_equal "Movie was successfully added.", flash[:notice]
    puts @movies
    assert_select ".title:nth-child(1)",
                  "Rick Astley - Never Gonna Give You Up (Official Music Video)"
  end
end
