class RecommendController < ApplicationController
  def index
		@schools = School.all
  end

  def result
		lectures = params[:lecture_id].split(',').map(&:to_i) # convert string to array
		overlapChecker = Hash.new{ |hash, key| hash[key] = [] }

		if lectures.length == 1
			@result = [lectures] and return
		end
		if lectures.length == 2
			Lecturetime.where(lecture_id: lectures[0]).each do |l0|
				Lecturetime.where(lecture_id: lectures[1]).each do |l1|
					if l0.day == l1.day && ( (l0.starttime < l1.starttime && l1.starttime < l0.endtime) || (l0.starttime < l1.endtime && l1.endtime < l0.endtime) || (l1.starttime < l0.starttime && l0.starttime < l1.endtime) || (l1.starttime < l0.endtime && l0.endtime < l1.endtime) || (l0.starttime == l1.starttime && l0.endtime == l1.endtime) )
						@result = [ [lectures[0]], [lectures[1]] ] and return
					end
				end
			end
			@result = [ [lectures[0], lectures[1]] ] and return
		end

		for i in 0..(lectures.length-1-1)
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

		@result = []
		lectures.each do |l|
			@result += recommend([l],lectures,overlapChecker)
		end
		@result.sort!.uniq!.each do |r|
			r.sort!
		end
		@result.uniq!
		@checker = overlapChecker
  end

	def recommend(mustVal, array, checker)
		result = []
		args = array-[mustVal.last]-checker[mustVal.last]
		if args == []
			result << mustVal
		else
			args.each do |a|
				result += [mustVal] + recommend(mustVal+[a],args,checker)
			end
		end

		return result
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
