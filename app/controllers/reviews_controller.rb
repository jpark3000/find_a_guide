class ReviewsController < ApplicationController
  def create
    @review = Review.new(create_params)

    if @review.save
      redirect_to :root
    else
      redirect_to :root
    end

  end

  def new
    @reviewee = User.find(params["user_id"])
    @meetup = Meetup.where('ambassador_id = ? AND visitor_id = ?', (current_user.id || @reviewee.id), (current_user.id || @reviewee.id)).first
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
