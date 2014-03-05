class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :require_login
  skip_before_action :require_login, only: [:index, :error_error_routing_error]

  def error_error_routing_error
    render :error_error_routing_error
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login(return_point = request.url)
    unless current_user
      flash[:error] = "Please log in using Facebook."
      set_return_point(return_point)
      redirect_to '/auth/facebook/'
    end
  end

  def return_point
    session[:return_point] ? session[:return_point] : :back
  end

  def set_return_point(path, overwrite = false)
    if overwrite || session[:return_point].blank?
      session[:return_point] = path
    end
  end

  helper_method :current_user, :return_point
end
