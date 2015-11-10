class TimetableController < ApplicationController
  def index
  end

  def new
		@lectures = Lecture.all
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
