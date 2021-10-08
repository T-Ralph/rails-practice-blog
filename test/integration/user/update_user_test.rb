require "test_helper"

class UpdateUserTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    sign_in(@admin_user)
  end

  test "edit user form and edit user details" do
    get edit_user_url(@admin_user)
    assert_response :success
    patch user_url(@admin_user), params: { user: { username: "admin_updated" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Updated", response.body
  end

  test "edit category form and reject invalid category" do
    get edit_user_url(@admin_user)
    assert_response :success
    patch user_url(@admin_user), params: { user: { username: "" } }
    assert_response :success
    assert_match "Error", response.body
  end

end
