require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    sign_in(@admin_user)
  end

  test "new category form and create new category" do
    get new_category_url
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "new category form and reject invalid category" do
    get new_category_url
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "" } }
    end
    assert_match "Errors", response.body
  end

end
