class Review < ActiveRecord::Base
	belongs_to :reviewer, class_name: "User"
	belongs_to :reviewee, class_name: "User"

	has_one :star
end
