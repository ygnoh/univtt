class School < ActiveRecord::Base
	### Associations
	has_many :buildings
	has_many :departments
	has_many :classifications
	has_many :providers

	### Validations
	validates :school_name, presence: true

	### Scopes
	default_scope { where(active: true) }
end
