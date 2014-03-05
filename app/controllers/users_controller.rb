class UsersController < ApplicationController
  skip_before_action :require_login, only: [:search, :update_profile_pic]

  def index
    @specialties = Specialty.all
    @languages = Language.all
    @tours = []
  end

  # def filter_by_specialty(specialty_id)
  #   if params[:specialty_id]
  #     @users = User.specialties



  #   end


  # end

  def search
    points = []
    gon.bounds = format_bounds(params[:initial_bounds]) if params[:initial_bounds]
    session[:start_date] = params[:start_date] if params[:start_date]
    session[:end_date]  = params[:end_date] if params[:end_date]

    @specialties = Specialty.all
    # @languages = Language.all
    respond_to do |format|
      if request.xhr?
        bounds = format_bounds(params[:bounds])
        
        @tours = Tour.where(Geocoder::Sql.within_bounding_box(bounds[0], bounds[1],
                                                              bounds[2], bounds[3],
                                                              'latitude', 'longitude'))
        @users = get_unique_users_from_tours(@tours)
 
        @tours.each do |tour|
          points << tour.format_coordinates
        end

        format.json do
          hashy = {points: points, users: {}}

          @users.each do |u|
            hashy[:users][u.id] = {id: u.id, first_name: u.first_name, tagline: u.tagline, rating: u.average_rating(:ambassador), photo: u.profile_pic, specialty_ids: u.specialties.map { |s| s.id } }
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
    current_user.ambassador_availability ? current_status = 'Unavailable' : current_status = 'Available'
    current_user.ambassador_availability ? new_status = 'Available' : new_status = 'Unavailable'
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

  def format_bounds(bounds)
    bounds.gsub!(/\(+|\)+/, '').split(',').map! { |i| i.to_f }
  end

  def get_unique_users_from_tours(tours)
    tours.map { |tour| tour.ambassador }.uniq
  end
end
