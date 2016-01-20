class Classification < ActiveRecord::Base
	### Associations
	belongs_to :school

	has_many :lectures

	### Validations
	validates :school, presence: true
	validates :classification_name, presence: true

	### Scopes
	default_scope { where(active: true) }
end
