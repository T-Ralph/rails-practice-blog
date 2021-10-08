require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
  end

  test "should sign in with valid credentials" do
    post login_path, params: { session: { email: "admin@rails.com", password: "AdminPassword" } }
    assert_equal session[:user_id], @admin_user.id
    assert_redirected_to user_url(@admin_user)
  end

  test "should not sign in with invalid credentials" do
    post login_path, params: { session: { email: "admin_2@rails.com", password: "InvalidAdminPassword" } }
    assert_nil session[:user_id]
    assert_equal login_path, path
  end

  test "should log out and delete session" do
    sign_in(@admin_user)
    delete logout_path
    assert_nil session[:user_id]
  end

end