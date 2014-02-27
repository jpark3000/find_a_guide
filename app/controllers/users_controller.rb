class UsersController < ApplicationController
  def index
    @specialties = Specialty.all
    @languages = Language.all
    @tours = Tour.all
  end
end