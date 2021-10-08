require 'test_helper'

class ArticleCategoryTest < ActiveSupport::TestCase

  def setup
    @admin_user = User.new(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    @category = Category.new(name: "Category Test")
    @article = Article.new(title: "Article Test", description: "Article Description", user: @admin_user)
    @article_category = ArticleCategory.new(article: @article, category: @category)
  end

  test "article_category should be valid" do
    assert @article_category.valid?
  end

  test "article_category should have article and category" do
    @article_category.article = nil
    @article_category.category = nil
    assert_not @article_category.valid?
  end

end