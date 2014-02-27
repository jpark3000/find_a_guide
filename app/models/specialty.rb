class Specialty < ActiveRecord::Base
	has_many :users_specialties
	has_many :users, through: :users_specialties

	validates :specialty, presence: true

  #TODO: this method needs to check if any ambassadors in that map view have that specialty
  def is_available?
    true
  end
end
