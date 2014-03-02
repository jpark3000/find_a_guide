namespace :email do
  desc "This task sends a reminder the day before a scheduled meetup"
  task :send_reminder => :environment do
    Email.send_reminder
  end

  desc "This task sends a reminder after a meetup to complete a review"
  task :request_review => :environment do
    Email.request_review
  end
end