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

end