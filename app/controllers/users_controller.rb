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
    @user = current_user
    @user.attributes = user_params
    if @user.save
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def ambassador_toggle
    @user = current_user

    if @user.is_ambassador == true
      @user.update(is_ambassador: false)
      redirect_to :dashboard
    else
      @user.update(is_ambassador: true)
      redirect_to :dashboard
    end

  end

  def dashboard
    @user = current_user
    @visitor_tours = @user.visitor_meetups.where('date_time > ?', Time.now)
    @visitor_incomplete_reviews = @user.empty_reviews(:visitor)
    @ambassador_tours = @user.ambassador_meetups.where('date_time > ?', Time.now)
    @ambassador_incomplete_reviews = @user.empty_reviews(:ambassador)
    @ambassador_overall_rating = @user.rating(:ambassador)
    @ambassador_ratings = @user.all_ratings(:ambassador)
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone, :gender, :age, :bio)
  end
end
