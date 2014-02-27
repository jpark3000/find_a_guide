class UsersController < ApplicationController
  def index
    @specialties = Specialty.all
    @languages = Language.all
    @tours = Tour.all
  end

  def edit
  end

  def update
  end
end