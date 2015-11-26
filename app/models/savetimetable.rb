class Savetimetable < ActiveRecord::Base
	serialize :lectures

	### Associations
	belongs_to :user

	### Validations
	validates :user, presence: true
	validates :lectures, presence: true

	### Scopes
	default_scope { where(active: true) }
	default_scope { order(created_at: :desc) }
end
