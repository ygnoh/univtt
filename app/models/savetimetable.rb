class Savetimetable < ActiveRecord::Base
	### Associations
	belongs_to :user

	### Validations
	validates :lectures, presence: true

	serialize :lectures
end
