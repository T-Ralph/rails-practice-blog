class ApplicationController < ActionController::Base

  helper_method :session_user, :session_state?

  def session_user
    @session_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def session_state?
    !!session_user
  end

  def session_required
    if !session_state?
      flash[:alert] = "Please, login"
      redirect_to login_path
    end
  end

end
