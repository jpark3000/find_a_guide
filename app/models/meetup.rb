class Meetup < ActiveRecord::Base
	belongs_to :tour
	belongs_to :ambassador, class_name: "User"
	belongs_to :visitor, class_name: "User"

	has_many :reviews

	validates :ambassador_id, :visitor_id, presence: true
  #TODO: verify that meetups are unique

  def self.pending_meetups
    start_datetime = Time.now.midnight + 1.day
    end_datetime = Time.now.midnight + 2.days
    meetups = where(date_time: start_datetime...end_datetime).includes(:ambassador, :visitor)
    recipients = Hash.new
    meetups.each do |meetup|
      recipients[meetup.ambassador.email] = {first_name: meetup.ambassador.first_name, user_id: meetup.ambassador.id, meetup_id: meetup.id, attendee_first_name: meetup.visitor.first_name}
      recipients[meetup.visitor.email] = {first_name: meetup.visitor.first_name, user_id: meetup.visitor.id, meetup_id: meetup.id, attendee_first_name: meetup.ambassador.first_name}
    end
    recipients
  end
end
