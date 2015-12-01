class RecommendController < ApplicationController
  def index
		@schools = School.all
  end

  def result
		tempLectures = params[:lecture_id].split(',').map(&:to_i) # convert string to array
		dayRestrict = params[:day_restrict].to_i
		gradeRestrictOver = params[:grade_restrict_over].to_i
		gradeRestrictLess = params[:grade_restrict_less].to_i
		overlapChecker = Hash.new{ |hash, key| hash[key] = [] }

		lectures = tempLectures
		# day restrict
		if dayRestrict != -1
			tempLectures.each do |l|
				Lecturetime.where(lecture_id: l).each do |t|
					if t.day == dayRestrict
						lectures -= [l]
						next
					end
				end
			end
		end

		tempLectures = lectures
		# morning restrict
		if params.has_key?(:morning_restrict)
			tempLectures.each do |l|
				Lecturetime.where(lecture_id: l).each do |t|
					if t.starttime < 1200 || t.endtime < 1200 # if less than 1200, it is a morning lecture
						lectures -= [l]
						break
					end
				end
			end
		end

		if lectures.length == 0 # lectures can be empty array by restrictions
			flash[:alert] = "그 조건에는 가능한 시간표가 없어요."
			return redirect_to :back
		elsif lectures.length == 1
			tempResult = [lectures]
		elsif lectures.length == 2
			done = false # for checking if tempResult exists in length=2
			Lecturetime.where(lecture_id: lectures[0]).each do |l0|
				if !done
					Lecturetime.where(lecture_id: lectures[1]).each do |l1|
						if l0.day == l1.day && ( (l0.starttime < l1.starttime && l1.starttime < l0.endtime) || (l0.starttime < l1.endtime && l1.endtime < l0.endtime) || (l1.starttime < l0.starttime && l0.starttime < l1.endtime) || (l1.starttime < l0.endtime && l0.endtime < l1.endtime) || (l0.starttime == l1.starttime && l0.endtime == l1.endtime) )
							tempResult = [ [lectures[0]], [lectures[1]] ]
							done = true
						end
					end
				end
			end
			if !done
				tempResult = [ [lectures[0], lectures[1]], [lectures[0]], [lectures[1]] ]
			end
		else
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

			tempResult = []
			lectures.each do |l|
				tempResult += recommend([l],lectures,overlapChecker)
			end
			tempResult.uniq!
			tempResult.each do |r|
				r.sort!
			end
			tempResult = tempResult.uniq.sort { |x,y| y.length <=> x.length } # sort by length (desc)
		end

		# for printing information
		@grade = []
		@numb = []

		result = tempResult
		# grade restrict
		if gradeRestrictLess >= gradeRestrictOver
			tempResult.each do |rslt|
				gradeSum = 0
				rslt.each do |r|
					gradeSum += Lecture.find(r).grade # is 'map' better?
				end
				if !(gradeRestrictOver <= gradeSum && gradeSum <= gradeRestrictLess)
					result -= [rslt] # remove
				else
					@grade << gradeSum # save total grade for printing information
					@numb << rslt.length # save number of lectures in this timetable
				end
			end
			if result.length == 0
				flash[:alert] = "그 조건에는 가능한 시간표가 없어요."
				return redirect_to :back
			end
		else
			flash[:error] = "학점 범위가 잘못되었습니다."
			return redirect_to :back
		end

		@result = result # for saving recommended timetable
		@result_times = []
		result.each do |rslt|
			@result_times << [] # [[ ]]
			rslt.each do |r|
				@result_times.last << [] # [ [[ ]] ]
				lecturename = Lecture.find(r).lecture_name
				foo = Lecturetime.where(lecture_id: r)
				if foo.empty? # if 'r' has no lecturetime
					@result_times.last.last << [lecturename] # just insert its lecturename
				else
					foo.each do |l|
						@result_times.last.last << [l.day, l.starttime/100*100+l.starttime%100*100/60, l.endtime/100*100+l.endtime%100*100/60, lecturename] # [[ [[ "here" ]] ]]
					end
				end
			end
		end
		 #@result_times = rslt.page(params[:page]).per(3)
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
