class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :session_permitted_user, except: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category Created!"
      redirect_to @category
    else
      render 'new'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category Updated!"
      redirect_to @category
    else
      render 'edit'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def session_permitted_user
    if !(session_state? && session_user.admin?)
      flash[:alert] = "Not Permitted"
      redirect_to categories_path
    end
  end

end