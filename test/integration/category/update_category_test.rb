require "test_helper"

class UpdateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    sign_in(@admin_user)
    @category = Category.create(name: "Sports")
  end

  test "edit category form and edit new category" do
    get edit_category_url(@category)
    assert_response :success
    patch category_url(@category), params: { category: { name: "Travel" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Updated", response.body
  end

  test "edit category form and reject invalid category" do
    get edit_category_url(@category)
    assert_response :success
    patch category_url(@category), params: { category: { name: "" } }
    assert_response :success
    assert_match "Error", response.body
  end

end
