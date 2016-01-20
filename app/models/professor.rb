class Professor < ActiveRecord::Base
	### Associations
	belongs_to :department
	
	has_many :lectures

	### Validations
	validates :department, presence: true
	validates :professor_name, presence: true

	### Scopes
	default_scope { where(active: true) }
end
