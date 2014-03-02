class User < ActiveRecord::Base
	# has_one :authentication, dependent: :destroy

	has_many :users_specialties
	has_many :specialties, through: :users_specialties

	has_many :languages_spoken
	has_many :languages, through: :languages_spoken

  has_many :visitor_reviews, through: :visitor_meetups, source: :reviews
  has_many :ambassador_reviews, through: :ambassador_meetups, source: :reviews

	has_many :reviews_given, class_name: "Review", foreign_key: "reviewer_id"
	has_many :reviews_received, class_name: "Review", foreign_key: "reviewee_id", dependent: :destroy

	has_many :tours, class_name: "Tour", foreign_key: "ambassador_id", dependent: :destroy

	has_many :ambassador_meetups, class_name: "Meetup", foreign_key: "ambassador_id", dependent: :destroy
	has_many :visitor_meetups, class_name: "Meetup", foreign_key: "visitor_id"

	validates :first_name, :last_name, presence: true

	def name
 		"#{first_name} #{last_name}"
	end

	def rating
		"#{rand(5)} stars"
	end

  def profile_pic(uid = self.uid)
    return "http://graph.facebook.com/#{uid}/picture"
  end

  def open_information
    [email,phone,gender,age]
  end

  def has_specialty?(specialty)
    self.specialties.any? {|s| s == specialty}
  end

  def empty_reviews(type)
    if type == :visitor
      self.visitor_meetups.where('date_time < ?', Time.now) - self.visitor_reviews.map{|r| r.meetup}
    else
      self.ambassador_meetups.where('date_time < ?', Time.now) - self.ambassador_reviews.map{|r| r.meetup}
    end
  end

  def incomplete_information
    possible_incomplete_attributes = ['tagline','bio','email','phone','gender','age']
    hash = self.attributes.select{|k,v| v.nil? && possible_incomplete_attributes.include?(k)}.keys
  end

  def average_rating(type)
    ratings = all_ratings(type)
    if ratings.empty?
      return false
    else
      ratings.map{|r| r.rating.to_i}.reduce(:+) / ratings.count
    end
  end

  def all_ratings(type) #specify ambassador ratings
    reviews_received.where('reviewee_id = ?', id)
  end

  def find_meetup(reviewee)
    @user_meetups = Meetup.where('ambassador_id = ? OR visitor_id = ?', id, id)
    @meetup = @user_meetups.select{|m| m.reviews.all && (m.ambassador_id == reviewee.id || m.visitor.id == reviewee.id)}.first
  end  

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)

      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.extra.raw_info.email

      user.username = auth.extra.raw_info.username
      user.gender = auth.extra.raw_info.gender
      # user.birthday = auth.extra.raw_info.birthday

      user.save!
    end
  end






end

