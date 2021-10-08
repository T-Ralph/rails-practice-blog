require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
  end

  test "new signup form and create new user" do
    get signup_url
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "admin2", email: "admin2@rails.com", password: "admin2password", admin: true } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Successful", response.body
  end

end
