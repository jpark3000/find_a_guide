class Meetup < ActiveRecord::Base
	belongs_to :tour
	belongs_to :ambassador, class_name: "User"
	belongs_to :visitor, class_name: "User"
end
