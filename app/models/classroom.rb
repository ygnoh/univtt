class Classroom < ActiveRecord::Base
	### Associations
	belongs_to :building

	has_many :lecture_times

	### Validations
	validates :building, presence: true
	validates :classroom_name, presence: true
end
