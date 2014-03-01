class MeetupsController < ApplicationController
  def index
    @ambassador = User.find(params[:user_id])
    @tours = @ambassador.ambassador_meetups
  end

  def show
    @meetup = Meetup.find(params[:id])
    @ambassador = @meetup.ambassador
    @visitor = @meetup.visitor
    @ambassador_attributes = @ambassador.open_information
    @visitor_attributes = @visitor.open_information
  end

  def edit
    @meetup = Meetup.find(params[:id])
    @ambassador = @meetup.ambassador
    @visitor = @meetup.visitor
    @ambassador_attributes = @ambassador.open_information
    @visitor_attributes = @visitor.open_information
  end

  def update
    @meetup = Meetup.find(params[:id])
    @meetup.attributes = meetup_params
    respond_to do |format|
      if @meetup.save
        format.json{ render :json => {new_url: user_meetup_url(current_user.id, @meetup.id)}}
      else
        format.json{ render :json => {errors: @meetup.errors.full_messages} }
      end
    end
  end

  private

  def meetup_params
    params.require(:meetup).permit(:date_time, :meetup_notes)
  end
end