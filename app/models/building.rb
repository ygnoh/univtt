class Building < ActiveRecord::Base
	### Associations
	belongs_to :school

	has_many :classrooms

	### Validations
	validates :school, presence: true
	validates :building_name, presence: true
end
