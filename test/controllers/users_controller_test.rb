require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post users_url, params: { user: { username: "admin_2", email: "admin_2@rails.com", password: "AdminPassword", admin: true } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@admin_user)
    assert_response :success
  end

  test "should get edit" do
    sign_in(@admin_user)
    get edit_user_url(@admin_user)
    assert_response :success
  end

  test "should update article" do
    sign_in(@admin_user)
    patch user_url(@admin_user), params: { user: { username: "admin update" } }
    assert_redirected_to user_url(@admin_user)
  end

end