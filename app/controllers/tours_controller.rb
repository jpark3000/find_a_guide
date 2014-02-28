class ToursController < ApplicationController
  def show
    @ambassador = User.first
    @selected_tour = Tour.find(params[:id])
  end

  def new
  end

  def create
  	puts params
  end
end