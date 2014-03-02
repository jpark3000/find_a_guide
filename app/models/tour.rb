class Tour < ActiveRecord::Base
	belongs_to :ambassador, :class_name => "User"
	has_many :meetups

	validates :ambassador_id, :longitude, :latitude, :description, presence: true

	reverse_geocoded_by :latitude, :longitude
	after_validation :geocode


	def format_coordinates
		[latitude, longitude]
	end

	
end
