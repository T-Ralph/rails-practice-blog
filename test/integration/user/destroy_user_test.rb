require "test_helper"

class DestroyUserTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    sign_in(@admin_user)
  end

  test "load user delete user path and redirect" do
    get user_url(@admin_user)
    assert_response :success
    assert_difference 'User.count', -1 do
      delete user_url(@admin_user)
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_equal signup_path, path
  end

end