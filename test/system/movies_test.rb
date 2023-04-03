require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  test "Sharing a new movie page" do
    # When we visit the Quotes#index page
    # we expect to see a title with the text "Quotes"
    visit home_path
    assert_selector "h1", text: "Movies"

    # When we click on the link with the text "New quote"
    # we expect to land on a page with the title "New quote"
    click_on "Share a movie"
    assert_selector "h1", text: "Share a movie"

    # When we fill in the name input with "Capybara quote"
    # and we click on "Create Quote"
    fill_in "url", with: "https://www.youtube.com/watch?v=Ks-_Mh1QhMc"
    click_on "Share"

    # We expect to be back on the page with the title "Quotes"
    # and to see our "Capybara quote" added to the list
    assert_selector "h1", text: "Quotes"
    assert_text "Capybara quote"
  end
end