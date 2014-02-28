class Meetup < ActiveRecord::Base
	belongs_to :tour
	belongs_to :ambassador, class_name: "User"
	belongs_to :visitor, class_name: "User"

	has_many :reviews

	validates :ambassador_id, :visitor_id, :date_time, :address, :tour_id,
						presence: true
  #TODO: verify that meetups are unique


end
