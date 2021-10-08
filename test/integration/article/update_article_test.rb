require "test_helper"

class UpdateArticleTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    sign_in(@admin_user)
    @category = Category.create(name: "Sports")
    @article = Article.create(title: "Article Test", description: "Article Description", user: @admin_user, categories: [@category])
  end

  test "edit article form and edit new article" do
    get edit_article_url(@article)
    assert_response :success
    patch article_url(@article), params: { article: { title: "Article Test Update" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Updated", response.body
  end

  test "edit category form and reject invalid article  update" do
    get edit_article_url(@article)
    assert_response :success
    patch article_url(@article), params: { article: { title: "" } }
    assert_response :success
    assert_match "Error", response.body
  end

end