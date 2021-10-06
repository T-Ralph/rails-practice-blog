class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :session_required, except: [:index, :show, :new, :create, :destroy]
  before_action :session_permitted_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Signup Successful!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Updated Successful!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    if @user == session_user
      session[:user_id] = nil
    end
    flash[:notice] = "Account and Articles Deleted!"
    redirect_to signup_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def session_permitted_user
    if session_user != @user && !session_user.admin?
      flash[:alert] = "Not Permitted!"
      redirect_to @user
    end
  end

end