class LandingPageController < ApplicationController
  # skip_before_action :require_login, only: [:index]

  def index
  end

  def require_login(return_point = request.url)
    unless current_user
      flash[:error] = "Please log in using Facebook."
      set_return_point(return_point)
      redirect_to '/auth/facebook/'
    end
  end

end
