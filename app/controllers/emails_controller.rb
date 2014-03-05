class EmailsController < ApplicationController
   skip_before_filter :verify_authenticity_token
   skip_before_action :require_login, only: [:reject]
   # include ActionController::Base.helpers

  def reply
   @recipient = User.find_by(anonymous_email: params[:recipient])
   @sender = User.find_by(email: params[:sender])
   @body = params["stripped-text"].split('\n')

   html = render_to_string "reply", :layout => false
   # text = strip_tags(html)

   message = {:to => @recipient.email, :html => html, :from => 'postmaster@sandbox57336.mailgun.org', :subject => params[:subject], "h:Reply-To" => @sender.anonymous_email}
   Email.send_message(message)

   render :text => "OK"
  end

  def new_request
    @visitor = current_user
    @ambassador = User.find(params[:ambassador_id])
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    subject = 'Message from City Bird: A New Visitor Needs Your Help!'
    email_html = render_to_string "new_request", :layout => false
    Email.new_request(@visitor, @ambassador, email_html, subject)
    respond_to do |format|
      format.json{ render :json => {response: 'Email Sent'}}
    end
  end

  def reject
    @ambassador = User.find(params[:ambassador_id])
    @visitor = User.find(params[:visitor_id])
    subject = 'Message from City Bird: Ambassador Unavailable'
    email_html = render_to_string "reject", :layout => false
    Email.new_request(@ambassador, @visitor, email_html, subject)
    render 'reject_acknowledge'
  end
end
