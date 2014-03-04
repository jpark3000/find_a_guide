class MeetupsController < ApplicationController
  skip_before_action :require_login, only: [:create, :edit]
  def index
    @ambassador = User.find(params[:user_id])
    @tours = @ambassador.ambassador_meetups
  end

  def show
    @meetup = Meetup.find(params[:id])
    @ambassador = @meetup.ambassador
    @visitor = @meetup.visitor
    @ambassador_attributes = @ambassador.open_information
    @visitor_attributes = @visitor.open_information
  end

  def edit
    @meetup = Meetup.find(params[:id])
    @ambassador = @meetup.ambassador
    @visitor = @meetup.visitor
    @ambassador_attributes = @ambassador.open_information
    @visitor_attributes = @visitor.open_information
  end

  def update
    @meetup = Meetup.find(params[:id])
    @meetup.attributes = meetup_params
    respond_to do |format|
      if @meetup.save
        format.json{ render :json => {new_url: user_meetup_url(current_user.id, @meetup.id)}}
      else
        format.json{ render :json => {errors: @meetup.errors.full_messages} }
      end
    end
  end

  def create
    @ambassador = User.find(params[:ambassador_id])
    @visitor = User.find(params[:visitor_id])
    date = params[:start_date].split("/").map(&:to_i)
    meetup = Meetup.create(ambassador_id: @ambassador.id, visitor_id: @visitor.id, date_time: DateTime.new(date[2], date[0], date[1]))
    subject = "#{@ambassador.name} will Meet You!"
    email_html = render_to_string "emails/accept", :layout => false
    Email.new_request(@ambassador, @visitor, email_html, subject)
    redirect_to edit_user_meetup_path(@ambassador, meetup)
  end

  private

  def meetup_params
    params.require(:meetup).permit(:date_time, :meetup_notes)
  end
end