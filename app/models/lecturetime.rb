class Lecturetime < ActiveRecord::Base
	### Associations
	belongs_to :lecture
	belongs_to :classroom

	### Validations
	validates :lecture, presence: true
	#validates :classroom, presence: true
	validates :day, presence: true, inclusion: { in: 0..6 }
	validates :starttime, presence: true
	validates :endtime, presence: true
end
