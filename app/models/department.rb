class Department < ActiveRecord::Base
	### Associations
	belongs_to :school

	### Validations
	validates :school, presence: true
	validates :department_name, presence: true
end
