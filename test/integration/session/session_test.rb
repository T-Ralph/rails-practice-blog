require "test_helper"

class SessionTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
  end

  test "should sign in with valid credentials" do
    get login_url
    assert_response :success
    post login_path, params: { session: { email: "admin@rails.com", password: "AdminPassword" } }
    assert_equal session[:user_id], @admin_user.id
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Successful", response.body
    assert_equal user_path(@admin_user), path
  end

  test "should not sign in with invalid credentials" do
    get login_url
    assert_response :success
    post login_path, params: { session: { email: "admin@rails.com", password: "InvalidAdminPassword" } }
    assert_nil session[:user_id]
    assert_response :success
    assert_match "Invalid", response.body
    assert_equal login_path, path
  end

  test "should sign out" do
    sign_in(@admin_user)
    get user_url(@admin_user)
    delete logout_path
    assert_response :success
    assert_nil session[:user_id]
    assert_match "Out", response.body
  end

end
