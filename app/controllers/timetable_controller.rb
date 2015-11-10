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
end
