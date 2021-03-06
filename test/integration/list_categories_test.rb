require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @category1 = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test "categories should list on index page with links to show respective page" do
    get '/categories'
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

end
