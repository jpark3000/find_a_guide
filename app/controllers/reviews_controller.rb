class ReviewsController < ApplicationController
  def create
  end

  def new
    @reviewee = User.find(params["user_id"])
    @meetup = current_user.visitor_meetups.find_by_ambassador_id(@reviewee.id)
    @rating_options = (1..5).to_a
    @review = Review.new
  end

  def update
  end
end