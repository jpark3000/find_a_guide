class EmailsController < ApplicationController
   skip_before_filter :verify_authenticity_token
   # include ActionController::Base.helpers

  def reply
   @recipient = User.find_by(anonymous_email: params[:recipient])
   @sender = User.find_by(email: params[:sender])
   @body = params["stripped-text"]

   html = render_to_string "reply"
   # text = strip_tags(html)

   message = {:to => @recipient.email, :html => html, :from => 'postmaster@sandbox57336.mailgun.org', :subject => params[:subject], "h:Reply-To" => @sender.fake_email}
   Mailgun.send_message(message)
   
   render :text => "OK"
  end

  def new_request
    @visitor = params[:visitor_id]
    @ambassador = params[:ambassador_id]
    email_html = render_to_string "new_request"
    Email.new_request(@visitor, @ambassador, email_html)
  end
end