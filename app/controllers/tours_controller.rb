class ToursController < ApplicationController
  def show
    @ambassador = User.first
    @selected_tour = Tour.find(params[:id])
  end

  def new
  end

  def create
  	puts "************ THESE ARE THE PARAMS #{params}"
  end

  private
  # def tour_params
  # 	params.require(:tour).permit(:)
  # end
end