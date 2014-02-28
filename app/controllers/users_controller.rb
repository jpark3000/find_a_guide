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
      render template: 'edit'   
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone, :gender, :age, :bio)
  end
end