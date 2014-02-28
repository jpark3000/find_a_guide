class MeetupsController < ApplicationController
  def index
  end

  def show
  end

  def edit
    @meetup = current_user.ambassador_meetups.find(params[:id])
    @ambassador = @meetup.ambassador
    @visitor = @meetup.visitor
  end

  def update
  end
end