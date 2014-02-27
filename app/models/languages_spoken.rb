class LanguagesSpoken < ActiveRecord::Base
	belongs_to :user
	belongs_to :language

	validates :user_id, :language_id, presence: true
end
