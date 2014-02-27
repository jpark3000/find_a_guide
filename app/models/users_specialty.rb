  class UsersSpecialty < ActiveRecord::Base
	belongs_to :user
	belongs_to :specialty

	validates :user_id, :specialty_id, presence: true
	
end
