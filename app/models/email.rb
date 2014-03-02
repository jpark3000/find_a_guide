class Email
  API_KEY = ENV['MAILGUN_API_KEY']
  API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/sandbox57336.mailgun.org"

  def self.send_message(message)  
    RestClient.post API_URL+"/messages", message
  end


  def self.new_request(sender, recipient, html, subject)
    # text = strip_tags(html) 

    message = {:to => recipient.email, :html => html, :from => 'postmaster@sandbox57336.mailgun.org', 
      :subject => subject, "h:Reply-To" => sender.anonymous_email}
    self.send_message(message)
  end

  def self.send_reminder
    root = ENV['DOMAIN']
    html = ActionController::Base.new().render_to_string(:template => '/emails/reminder', :layout => false, :locals => {:root=>root})
    recipients = Meetup.pending_meetups
    message = {:to => recipients.keys, :html => html, :from => 'postmaster@sandbox57336.mailgun.org', 
      :subject => 'Upcoming Meetup', "recipient-variables" => recipients.to_json}
    self.send_message(message)
  end

  def self.request_review
    root = ENV['DOMAIN']
    html = ActionController::Base.new().render_to_string(:template => '/emails/review', :layout => false, :locals => {:root=>root})
    recipients = Meetup.completed_meetups
    message = {:to => recipients.keys, :html => html, :from => 'postmaster@sandbox57336.mailgun.org', 
      :subject => 'Rate Your Experience', "recipient-variables" => recipients.to_json}
    self.send_message(message)
  end
end

   