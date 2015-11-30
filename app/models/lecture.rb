class Lecture < ActiveRecord::Base
	### Associations
	belongs_to :department
	belongs_to :professor
	belongs_to :classification

	has_many :lecturetimes
	has_many :lcomments
	### Validations
	validates :department, presence: true
	validates :classification, presence: true
	validates :year, presence: true
	validates :semester, presence: true
	validates :lecture_name, presence: true
	validates :level, presence: true
	validates :lecture_number, presence: true
	validates :lecture_division, presence: true
	validates :grade, presence: true
end
