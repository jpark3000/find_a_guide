require 'pry'

class ReviewsController < ApplicationController
  def create
    @review = Review.new(create_params)
    respond_to do |format|
      if @review.save
        format.json{ render :json => {new_url: dashboard_url}}
      else
        format.json{ render :json => {errors: @review.errors.full_messages} }
      end
    end
  end

  def new
    @reviewee = User.find(params["user_id"])
    @meetup = current_user.find_meetup(@reviewee)
    @rating_options = (1..5).to_a
    @review = Review.new
  end

  def update
  end

  private
  def create_params
    params.require(:review).permit(:rating, :comment, :meetup_id, :reviewee_id, :reviewer_id)
  end
end
