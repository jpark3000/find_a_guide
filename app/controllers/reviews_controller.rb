class ReviewsController < ApplicationController
  def create
    @review = Review.new(create_params)

    if @review.save
      redirect_to :root
    else
      @errors = @review.errors.full_messages

      flash[:message] = @errors

      redirect_to :back
    end

  end

  def new
    @reviewee = User.find(params["user_id"])
    @meetup = current_user.visitor_meetups.find_by_ambassador_id(@reviewee.id)
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
