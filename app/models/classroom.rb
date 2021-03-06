class Classroom < ActiveRecord::Base
	### Associations
	belongs_to :building

	has_many :lecturetimes

	### Validations
	validates :building, presence: true
	validates :classroom_name, presence: true
end
