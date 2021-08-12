require "test_helper"

# Integration testing tests the entire workflow of a section/feature of the application

class CreateCategoryTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: "admin", email: "admin@email.com", password: "admin", admin: true )
    set_user_as(@admin_user)
  end
  
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do #looks for change in the number of categories by 1
      post categories_path, params: { category: { name: "Sports" } } #posts a valid category name
      assert_response :redirect #redirects to the show page
    end
    follow_redirect! #follows the redirect to the show page
    assert_response :success
    assert_match "Sports", response.body # tries to find the word 'Sports' in the html <body> tag
  end

  test "get new category form and reject invalid category" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " " } }
    end
    assert_match "errors", response.body 
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end

end
