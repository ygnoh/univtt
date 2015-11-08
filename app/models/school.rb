class School < ActiveRecord::Base
	has_many :buildings
	validates :school_name, presence: true
end
