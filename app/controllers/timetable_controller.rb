class TimetableController < ApplicationController
  def index
  end

  def new
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

	def update_lectures
		if params[:department].to_i == 0
			@lectures = Department.find_by(department_name: params[:department]).lectures
		else
			@lectures = Department.find(params[:department]).lectures
		end

		respond_to do |format|
			format.json { render :json => @lectures.to_json }
		end
	end
end
