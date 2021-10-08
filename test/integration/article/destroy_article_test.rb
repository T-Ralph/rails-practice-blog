require "test_helper"

class DestroyArticleTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    sign_in(@admin_user)
    @category = Category.create(name: "Sports")
    @article = Article.create(title: "Article Test", description: "Article Description", user: @admin_user, categories: [@category])
  end

  test "load article delete article path and redirect" do
    get article_url(@article)
    assert_response :success
    assert_difference 'Article.count', -1 do
      delete article_url(@article)
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_equal articles_path, path
  end

end