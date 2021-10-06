class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :session_required, except: [:index, :show]
  before_action :session_permitted_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = session_user
    if @article.save
      flash[:notice] = "Article Created!"
      #redirect_to article_path(@article)
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article Updated!"
      #redirect_to article_path(@article)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def session_permitted_user
    if session_user != @article.user && !session_user.admin?
      flash[:alert] = "Not Permitted"
      redirect_to @article
    end
  end
  
end