class RecommendController < ApplicationController
  def index
		@schools = School.all
  end

  def result
		lectures = params[:lecture_id].split(',').map(&:to_i) # convert string to array
		overlapChecker = Hash.new{ |hash, key| hash[key] = [] }

		for i in 0..(lectures.length-1-1) # length <=2 인 경우 따로해야 함
			Lecturetime.where(lecture_id: lectures[i]).each do |li|
				for j in (i+1)..(lectures.length-1)
					if overlapChecker[lectures[i]].include? lectures[j]
						next
					end

					Lecturetime.where(lecture_id: lectures[j]).each do |lj|
						if li.day == lj.day
							# Check if there exists overlap between li and lj
							if (lj.starttime < li.starttime && li.starttime < lj.endtime) || (lj.starttime < li.endtime && li.endtime < lj.endtime) || (li.starttime < lj.starttime && lj.starttime < li.endtime) || (li.starttime < lj.endtime && lj.endtime < li.endtime) || (li.starttime == lj.starttime && li.endtime == lj.endtime)
								overlapChecker[lectures[i]] << lectures[j]
								overlapChecker[lectures[j]] << lectures[i]
								break
							end
						end
					end
				end
			end
		end
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
