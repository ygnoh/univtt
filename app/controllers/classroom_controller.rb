class ClassroomController < ApplicationController
  def index
		@schools = School.all
		@buildings = Building.all
  end

	def update_classroom 
		@starttime = 0
		@endtime = 2400
		@classrooms = []
		@building_id = params[:building_id].to_i
		duration = 30 # length of empty lecture time(mins)
		time = Time.new.getlocal
		
		if params.has_key?(:now)
			@day = time.wday
			@starttime = time.strftime("%H%M").to_i
		else
				if params[:day].to_i == -1
					@day = time.wday
				else
					@day = params[:day].to_i
				end
				if params.has_key?(:starttime) && params.has_key?(:endtime)
					@starttime = params[:starttime].to_i
					@endtime = params[:endtime].to_i
				end
		end	

		Classroom.where(building_id: @building_id).each do |c|
			timebox = []
			c.lecturetimes.where(day: @day).each do |t|
				timebox << [ t.starttime, t.endtime, t.lecture_id ]
			end

			timeboxLength = timebox.length
			if timeboxLength == 0
				@classrooms << c
				next
			end
			if timeboxLength == 1
				if ( timebox.first[0]/100*60+timebox.first[0]%100 
						- (@starttime/100*60+@starttime%100) >= duration ) ||
					( @endtime/100*60+@endtime%100
						- (timebox.first[1]/100*60+timebox.first[1]%100) >= duration )
					@classrooms << c
				end
				next
			end

			timebox.sort! # order by start time

			indexbox = []
			included = false
			timebox.each_with_index do |t,i|
				if t[0] <= @starttime && @endtime <= t[1] # included case
					included = true
					break
				end
				if t[0].between?(@starttime,@endtime) 
					indexbox << i
					next
				end
				if t[1].between?(@starttime,@endtime)
					indexbox << i
					next
				end
			end
			if included
				next
			end

			if indexbox.empty?
				@classrooms << c
				next
			end

			startIndex = indexbox.min
			endIndex = indexbox.max
			
			if ( timebox[startIndex][0]/100*60+timebox[startIndex][0]%100
					- (@starttime/100*60+@starttime%100) >= duration ) ||
				( @endtime/100*60+@endtime%100
					- (timebox[endIndex][1]/100*60+timebox[endIndex][1]%100) >= duration )
				@classrooms << c
				next
			end

			for i in startIndex..(endIndex-1)
				if timebox[i+1][0]/100*60+timebox[i+1][0]%100 - (timebox[i][1]/100*60+timebox[i][1]%100) >= duration
					@classrooms << c
					break
				end
			end
		end

		respond_to do |format|
			format.js
		end
	end

  def new
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
