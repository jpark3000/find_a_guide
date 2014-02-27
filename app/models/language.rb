class Language < ActiveRecord::Base
	has_many :languages_spoken
	has_many :users, through: :languages
end
