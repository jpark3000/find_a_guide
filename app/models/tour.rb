class Tour < ActiveRecord::Base
	belongs_to :ambassador, :class_name => "User"
	has_many :meetups
end
