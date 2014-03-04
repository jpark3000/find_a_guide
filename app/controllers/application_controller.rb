class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :require_login
  skip_before_action :require_login, only: [:index]

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      flash[:error] = "Please log in using Facebook."
      redirect_to :root
    end
  end

  helper_method :current_user
end
