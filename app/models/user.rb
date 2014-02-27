class User < ActiveRecord::Base
	has_one :authentication, dependent: :destroy

	has_many :users_specialties
	has_many :specialties, through: :users_specialties

	has_many :languages_spoken
	has_many :languages, through: :languages_spoken

	has_many :reviews_given, class_name: "Review", foreign_key: "reviewer_id"
	has_many :reviews_received, class_name: "Review", foreign_key: "reviewee_id", dependent: :destroy

	has_many :tours, class_name: "Tour", foreign_key: "ambassador_id", dependent: :destroy

	has_many :ambassador_meetups, class_name: "Meetup", foreign_key: "ambassador_id", dependent: :destroy
	has_many :visitor_meetups, class_name: "Meetup", foreign_key: "visitor_id"

	validates :first_name, :last_name, :email, :phone, :profile_pic,
	 					:bio, :gender, :age, presence: true

	def name
 		"#{first_name} #{last_name}"
	end

	def rating
		"#{rand(5)} stars"
	end

	# def review_score
	# 	self.reviews_received
	# end

end

