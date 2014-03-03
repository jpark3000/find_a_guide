class ToursController < ApplicationController

  def edit
  end

  def new
    @ambassador = current_user
  end

  def create
    # @tour = Tour.new(description: params[:description], latitude: params[:latitude], longitude: params[:longitude], ambassador_id: params[:user_id])
    @tour = Tour.new(tour_params)
    @tour.ambassador_id = params[:user_id]
    respond_to do |format|
      format.json do
        if @tour.save
          render :json => {message: "SUCCESS!", success: true}
        else
          render :json => {message: "Unable to save post", success: false}
        end
      end
    end
  end

  def index
    @ambassador = current_user
  end

  private
  def tour_params
    params.require(:tour).permit(:description, :latitude, :longitude, :user_id)
  end

end
