class Tour < ActiveRecord::Base
	belongs_to :ambassador, :class_name => "User"
	has_many :meetups

	validates :ambassador_id, :longitude, :latitude, :description, presence: true
  # Custom Validations
  validate :you_cannot_drop_pin_if_notambassador, on: :create

	reverse_geocoded_by :latitude, :longitude
	after_validation :geocode

  #Custom Validaton Methods
  def you_cannot_drop_pin_if_notambassador
    ambassador_status = User.find(self.ambassador_id).is_ambassador
    if ambassador_status == false
      errors.add(:meetup_id, "you cannot drop a pin unless you are an ambassador")
      return false
    end
  end

	def format_coordinates
		[latitude, longitude, ambassador.id, description]
	end

  def format_object
    {lat: latitude, lng: longitude, id: id, desc: description}
  end




end
