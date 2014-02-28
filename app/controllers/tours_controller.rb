class ToursController < ApplicationController
  def show
    @ambassador = User.first
    @selected_tour = Tour.find(params[:id])
  end


  def new
    @ambassador = current_user
    @specialties = Specialty.all
  end

  def create
    puts "THSE ARE THE PARAMS************** #{params}"
  end

  def index
  end

end