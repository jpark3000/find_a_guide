class User < ActiveRecord::Base
	# has_one :authentication, dependent: :destroy

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
	 					:bio, :gender, :age, :authentication, presence: true


	def edit
	end

	def update
	end


	def name
 		"#{first_name} #{last_name}"
	end

	# def review_score
	# 	self.reviews_received
	# end



def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end




end

