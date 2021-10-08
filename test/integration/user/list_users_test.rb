require "test_helper"

class ListUsersTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user_1 = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    @user_2 = User.create(username: "user", email: "user@rails.com", password: "UserPassword", admin: false)
  end

  test "show users listing" do
    get users_url
    assert_select "a[href=?]", user_path(@admin_user_1), text: "Profile"
    assert_select "a[href=?]", user_path(@user_2), text: "Profile"
  end

end
