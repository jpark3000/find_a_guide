class UsersController < ApplicationController

  def index
    @specialties = Specialty.all
    @languages = Language.all
    @tours = Tour.all
  end

  def edit
    @user = current_user
  end

  def update
  end

  def dashboard
    @user = current_user
    @visitor_tours = @user.visitor_meetups
    @visitor_incomplete_reviews = @user.empty_reviews(:visitor)
    @ambassador_tours = @user.ambassador_meetups
    @ambassador_incomplete_reviews = @user.empty_reviews(:ambassador)
    @ambassador_overall_rating = @user.rating(:ambassador)
    @ambassador_ratings = @user.all_ratings(:ambassador) 
  end
end