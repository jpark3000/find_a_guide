class MeetupsController < ApplicationController
  def index
  end

  def show
  end

  def edit
    @meetup = current_user.ambassador_meetups.find(params[:id])
    @ambassador = @meetup.ambassador
    @visitor = @meetup.visitor
    @ambassador_attributes = @ambassador.open_information
    @visitor_attributes = @visitor.open_information
  end

  def update
  end
end