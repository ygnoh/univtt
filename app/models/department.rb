class Department < ActiveRecord::Base
	### Associations
	belongs_to :school

	has_many :professors
	has_many :lectures

	### Validations
	validates :school, presence: true
	validates :department_name, presence: true
end
