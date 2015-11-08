class Building < ActiveRecord::Base
	### Associations
	belongs_to :school

	### Validations
	validates :school, presence: true
	validates :building_name, presence: true
end
