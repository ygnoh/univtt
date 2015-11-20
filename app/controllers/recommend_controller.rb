class RecommendController < ApplicationController
  def index
		@schools = School.all
  end

  def result
		@lectures = params[:lecture_id].split(',').map(&:to_i) # convert string to array
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

	def update_wishbox
		@lecture = Lecture.find(params[:lecture_id])
		
		respond_to do |format|
			format.js
		end
	end
end
