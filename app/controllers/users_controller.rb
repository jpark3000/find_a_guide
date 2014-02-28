class UsersController < ApplicationController

  def index
    @specialties = Specialty.all
    @languages = Language.all
    @tours = Tour.all
  end

  def edit
    @user = current_user
  end

  def update
  end

  def dashboard
    @user = current_user
    @visitor_tours = @user.visitor_meetups
  end
end