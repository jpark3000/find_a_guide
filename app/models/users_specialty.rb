class UsersSpecialty < ActiveRecord::Base
	belongs_to :user
	belongs_to :specialty
end
