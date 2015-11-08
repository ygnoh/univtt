class Classification < ActiveRecord::Base
	### Associations
	belongs_to :school

	### Validations
	validates :school, presence: true
	validates :classification_name, presence: true
end
