require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @category = Category.create(name: "Sports")
    @admin_user = User.create(username: "admin", email: "admin@rails.com", password: "AdminPassword", admin: true)
    @article = Article.create(title: "Article Test", description: "Article Description", user: @admin_user, categories: [@category])
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    sign_in(@admin_user)
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    sign_in(@admin_user)
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: "Article Test", description: "Article Description", categories: [@category] } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    sign_in(@admin_user)
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    sign_in(@admin_user)
    patch article_url(@article), params: { article: { title: "Article Test Update" } }
    assert_redirected_to article_url(@article)
  end

end
