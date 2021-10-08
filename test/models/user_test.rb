require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
  end

  test "user should be valid" do
    assert @admin_user.valid?
  end

  test "user should have username and email" do
    @admin_user.username = ""
    @admin_user.email = ""
    assert_not @admin_user.valid?
  end

  test "user email should be valid" do
    @admin_user.email = "admin@rails.com" * 50
    assert_not @admin_user.valid?
  end

  test "user username & email should be within length" do
    @admin_user.username = "admin" * 50
    @admin_user.email = ("admin" * 50) + "rails.com"
    assert_not @admin_user.valid?
  end

end