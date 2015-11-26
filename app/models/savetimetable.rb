class Savetimetable < ActiveRecord::Base
	### Associations
	belongs_to :user

	### Validations
	validates :user, presence: true
	validates :lectures, presence: true

	serialize :lectures
end
