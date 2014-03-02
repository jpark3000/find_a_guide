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
end
