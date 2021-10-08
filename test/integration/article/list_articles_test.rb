require "test_helper"

class ListArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    @category = Category.create(name: "Category Test")
    @article_1 = Article.create(title: "Article Test 1", description: "Article Description 1", user: @admin_user, categories: [@category])
    @article_2 = Article.create(title: "Article Test 2", description: "Article Description 2", user: @admin_user, categories: [@category])
  end

  test "show articles listing" do
    get articles_url
    assert_select "a[href=?]", article_path(@article_1), text: @article_1.title
    assert_select "a[href=?]", article_path(@article_2), text: @article_2.title
  end

end
