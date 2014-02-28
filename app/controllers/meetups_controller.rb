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
  end
end