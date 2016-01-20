class Provider < ActiveRecord::Base
	### Associations
	belongs_to :school

	### Validations
	validates :school, presence: true
	validates :name, presence: true
	validates :year, presence: true
	validates :semester, presence: true

	### Scopes
	default_scope { where(active: true) }
end
