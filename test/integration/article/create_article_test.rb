require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    @category = Category.create(name: "Category Test")
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    sign_in(@admin_user)
  end

  test "new article form and create new article" do
    get new_article_url
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Article Test", description: "Article Description Test", categories: [@category] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Created", response.body
  end

end
