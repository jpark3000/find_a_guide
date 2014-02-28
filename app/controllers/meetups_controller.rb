class MeetupsController < ApplicationController
  def index
    @ambassador = current_user
    @tours = @ambassador.ambassador_meetups
  end

  def show
    @meetup = current_user.ambassador_meetups.find(params[:id])
    @ambassador = @meetup.ambassador
    @visitor = @meetup.visitor
    @ambassador_attributes = @ambassador.open_information
    @visitor_attributes = @visitor.open_information
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