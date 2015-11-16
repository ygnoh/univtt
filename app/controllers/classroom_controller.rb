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
			if timebox.length <= 1 ## length = 1일 때 시간 가능한지 체크해야함
				@classrooms << c
				next
			end
			timebox.sort!

			startIndex = 0
			endIndex = timebox.length - 1
			timebox.each_with_index do |t, i|
				if @starttime >= t[0]
					startIndex = i
				end
				if @endtime >= t[1]
					endIndex = i
				end
			end

			if c.id == 1007015
				byebug
			end

			catch(:foo) do
				for i in startIndex..(endIndex-1)
					if (timebox[i+1][0] - timebox[i][1]) >= 30
						@classrooms << c
						throw(:foo) # escape loop
					end
				end
				if (@endtime - timebox[endIndex][1]) >= 30 
					@classrooms << c
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
