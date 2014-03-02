class EmailsController < ApplicationController
   skip_before_filter :verify_authenticity_token
   # include ActionController::Base.helpers

  def reply
   @recipient = User.find_by(anonymous_email: params[:recipient])
   @sender = User.find_by(email: params[:sender])
   @body = params["stripped-text"]

   html = render_to_string "reply"
   # text = strip_tags(html)

   message = {:to => @recipient.email, :html => html, :from => 'postmaster@sandbox57336.mailgun.org', :subject => params[:subject], "h:Reply-To" => @sender.anonymous_email}
   Email.send_message(message)

   render :text => "OK"
  end

  def new_request
    @visitor = current_user
    @ambassador = User.find(params[:ambassador_id])
    subject = 'A New Visitor Needs Your Help!'
    email_html = render_to_string "new_request", :layout => false
    Email.new_request(@visitor, @ambassador, email_html, subject)
  end

  def reject
    @ambassador = current_user
    @visitor = User.find(params[:visitor_id])
    subject = 'Ambassador Unavailable'
    email_html = render_to_string "reject", :layout => false
    Email.new_request(@ambassador, @visitor, email_html, subject)
  end
end
