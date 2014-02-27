class Specialty < ActiveRecord::Base
	has_many :users_specialties
	has_many :users, through: :users_specialties
end
