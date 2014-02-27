class User < ActiveRecord::Base
	has_one :authentication

	has_many :users_specialties
	has_many :specialties, through: :users_specialties

	has_many :languages_spoken
	has_many :languages, through: :languages

	has_many :reviews_given, class_name: "Review", foreign_key: "reviewer_id"
	has_many :reviews_received, class_name: "Review", foreign_key: "reviewee_id"

	has_many :tours, class_name: "Tour", foreign_key: "ambassador_id"

	has_many :ambassador_meetups, class_name: "Meetup", foreign_key: "ambassador_id"
	has_many :visitor_meetups, class_name: "Meetup", foreign_key: "visitor_id"
end

