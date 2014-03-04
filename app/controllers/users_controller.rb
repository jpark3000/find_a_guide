class UsersController < ApplicationController

  def index
    @specialties = Specialty.all
    @languages = Language.all
    @tours = []
  end

  def search
    points = []
    gon.lat = params[:center_lat]
    gon.lng = params[:center_lng]

    @specialties = Specialty.all
    @languages = Language.all

    respond_to do |format|
      if request.xhr?
        params[:bounds] = params[:bounds].gsub!(/\(+|\)+/, '').split(',').map! { |i| i.to_f }

        @tours = Tour.where(Geocoder::Sql.within_bounding_box(params[:bounds][0], params[:bounds][1],
                                                                     params[:bounds][2], params[:bounds][3],
                                                                     'latitude', 'longitude'))

        @users = @tours.map { |tour| tour.ambassador }.uniq
        @tours.each do |tour|
          points << tour.format_coordinates
        end

        format.json do
          hashy = {points: points, users: {}}

          @users.each do |u|
            hashy[:users][u.id] = {id: u.id, first_name: u.first_name, tagline: u.tagline, rating: u.rating, photo: u.profile_pic}
          end


          render :json => hashy
        end
      else
        gon.points = []
        @tours = Tour.near([params[:center_lat], params[:center_lng]], 500)
        @tours.each do |tour|
          gon.points << tour.format_coordinates
        end
        @users = @tours.map { |tour| tour.ambassador }
        format.html do
          render 'index'
        end
      end
    end

  end

  def edit
    @user = current_user
    @ambassador = current_user
    @specialties = Specialty.all
    gon.user_id = @user.id
  end

  def update
    current_user.specialties.destroy_all
    if params['specialty']
      new_specialties = params['specialty'].keys
      new_specialties.each{|specialty_id| UsersSpecialty.create(user_id: current_user.id, specialty_id: specialty_id)}
    end
    current_user.attributes = user_params
    current_user.save
    respond_to do |format|
        format.json{ render :json => {errors: current_user.errors.full_messages} }
    end
  end

# ----------------------------------------------------
  def update_profile_pic
    quasi_current_user = User.find(params[:user_id])
    quasi_current_user.update(profile_pic: params[:profile_pic])

    redirect_to :back
  end
# ----------------------------------------------------

  def show
    @user = User.find(params[:id])
  end

  def ambassador_toggle
    current_user.update(is_ambassador: true)
    respond_to do |format|
        format.json{ render :json => {is_ambasssador: current_user.is_ambassador}}
    end
  end

  def ambassador_availability_toggle
    current_user.update(ambassador_availability: params[:availability])
    current_user.ambassador_availability ? current_status = 'You are currently Available' : current_status = 'You are currently Unavailable'
    current_user.ambassador_availability ? new_status = 'Set status to Unavailable' : new_status = 'Set status to Available'
    current_user.ambassador_availability ? new_value = false : new_value = true
    respond_to do |format|
        format.json{ render :json => {current_status: current_status, new_status: new_status, new_value: new_value}}
    end
  end

  def dashboard
    @user = current_user
    @visitor_meetups = @user.visitor_meetups.where('date_time > ?', Time.now).order('date_time')
    @visitor_incomplete_reviews = @user.empty_reviews(:visitor)
    @ambassador_tours = @user.ambassador_meetups.where('date_time > ?', Time.now).order('date_time')
    @ambassador_incomplete_reviews = @user.empty_reviews(:ambassador)
    @ambassador_overall_rating = @user.average_rating(:ambassador)
    @ambassador_ratings = @user.all_ratings(:ambassador).order('created_at')
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone, :gender, :age, :bio, :tagline, :profile_pic)
  end


end
