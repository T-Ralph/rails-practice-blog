require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    @category = Category.create(name: "Category Test")
    @article = Article.new(title: "Article Test", description: "Article Description", user: @admin_user, categories: [@category])
  end

  test "article should be valid" do
    assert @article.valid?
  end

  test "article should have title and description" do
    @article.title = ""
    @article.description = ""
    assert_not @article.valid?
  end

  test "article should have a user" do
    @article.user = nil
    assert_not @article.valid?
  end

  test "article should have assigned category/category ids" do
    assert_not_nil @article.category_ids
  end

  test "article title & description should be within length" do
    @article.title = "Article Test" * 50
    @article.description = "Article Description" * 50
    assert_not @article.valid?
  end

end