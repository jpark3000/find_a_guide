class Meetup < ActiveRecord::Base
	belongs_to :tour
	belongs_to :ambassador, class_name: "User"
	belongs_to :visitor, class_name: "User"

	has_many :reviews

	validates :ambassador_id, :visitor_id, presence: true
  #Custom Validations
  validate :you_cannot_meet_with_yourself, on: :create
  validate :you_cannot_meet_with_nonambassador, on: :create

  #Custom Validaton Methods
  def you_cannot_meet_with_yourself
    if (self.ambassador == self.visitor || self.ambassador_id == self.visitor_id)
      errors.add(:meetup_id, "you cannot meet with yourself")
      return false
    end
  end

  def you_cannot_meet_with_nonambassador
    ambassador_status = User.find(self.ambassador_id).is_ambassador
    if ambassador_status == false
      errors.add(:meetup_id, "you cannot meet with someone who is not an ambassador")
      return false
    end
  end

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

  def self.completed_meetups
    start_datetime = Time.now.midnight - 1.day
    end_datetime = Time.now.midnight
    meetups = where(date_time: start_datetime...end_datetime).includes(:ambassador, :visitor)
    recipients = Hash.new
    meetups.each do |meetup|
      recipients[meetup.ambassador.email] = {first_name: meetup.ambassador.first_name, user_id: meetup.ambassador.id, meetup_id: meetup.id, attendee_first_name: meetup.visitor.first_name, attendee_id: meetup.visitor.id}
      recipients[meetup.visitor.email] = {first_name: meetup.visitor.first_name, user_id: meetup.visitor.id, meetup_id: meetup.id, attendee_first_name: meetup.ambassador.first_name, attendee_id: meetup.ambassador.id}
    end
    recipients
  end
end


