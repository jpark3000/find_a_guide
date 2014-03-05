class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to return_point
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
