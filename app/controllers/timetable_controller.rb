class TimetableController < ApplicationController
  def index
  end

  def new
		#@lectures = Lecture.all
		@lectures = Lecture.first(10)
		@schools = School.all
		@departments = Department.all
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

	# Department filter changed automatically
	def update_departments
		if params[:school].to_i == 0
			@departments = School.find_by(school_name: params[:school]).departments
		else
			@departments = School.find(params[:school]).departments
		end

		respond_to do |format|
			format.js
		end
	end
end
