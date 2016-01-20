class TimetableController < ApplicationController
	# global variables for provider
	$year = 2016
	$semester = 1

  def new
		@schools = School.all
  end

  def create
		savett = Savetimetable.new
		savett.user_id = current_user.id
		savett.lectures = params[:lectures].split(',').map(&:to_i) # convert string to array
		
		if savett.save
			flash[:success] = "성공적으로 저장하였습니다."
		else
			flash[:error] = "저장에 실패하였습니다."
		end

		redirect_to "/timetable/show/#{current_user.id}"
  end

	def show
		@ttlist = Savetimetable.where(user_id: params[:user_id])
		@username = User.find(params[:user_id]).username
	end

	def show_timetable
		@result = []
		@grade = 0
		@numb = 0
		@ttid = params[:tt_id].to_i
		Savetimetable.find(@ttid).lectures.each do |l|
			@result << [] # [ [ ] ]
			@grade += Lecture.find(l).grade
			@numb += 1
			lecturename = Lecture.find(l).lecture_name
			foo = Lecturetime.where(lecture_id: l)
			if foo.empty?
				@result.last << [lecturename]
			else
				foo.each do |t|
					@result.last << [t.day, t.starttime/100*100+t.starttime%100*100/60, t.endtime/100*100+t.endtime%100*100/60, lecturename]
				end
			end
		end
	end

  def edit
  end

  def update
  end

  def destroy
		tt = Savetimetable.find(params[:tt_id])
		tt.active = false
		if !user_signed_in? || tt.user_id != current_user.id
			flash[:error] = "해당 권한이 없습니다."
		else
			if tt.save
				flash[:success] = "삭제하였습니다."
			else
				flash[:error] = "삭제에 실패하였습니다."
			end
		end

		redirect_to "/timetable/show/#{tt.user_id}"
  end


	# Below actions are related with filter change automatically
	def update_departments
		if params[:school].to_i == 0
			@departments = School.find_by(school_name: params[:school]).departments
		else
			@departments = School.find(params[:school]).departments
		end

		@provider = Provider.where(school_id: params[:school], year: $year, semester: $semester).first

		respond_to do |format|
			format.js
		end
	end

	def update_classifications
		if params[:school].to_i == 0
			@classifications = School.find_by(school_name: params[:school]).classifications
		else
			@classifications = School.find(params[:school]).classifications
		end

		respond_to do |format|
			format.json { render :json => @classifications.to_json }
		end
	end

	def update_lectures_by_department
		if params[:department].to_i == 0
			@lectures = Department.find_by(department_name: params[:department]).lectures
		else
			@lectures = Department.find(params[:department]).lectures
		end

		@lecturetimes = []
		@classifications = []
		@professors = []

		@lectures.each do |l|
			@classifications << l.classification.classification_name
			@professors << (l.professor.nil? ? "unknown" : l.professor.professor_name)
			@lecturetimes << []
			l.lecturetimes.each do |t|
				@lecturetimes.last << t
			end
		end

		respond_to do |format|
			format.json { render :json => [@lectures,@lecturetimes,@classifications,@professors].to_json }
		end
	end

	def update_lectures_by_classification
		if params[:department].to_i % 10**8 == 0
			@lectures = []
			Classification.where(id: params['classification'].values).each do |c|
				@lectures += c.lectures
			end
		else
			foo = Department.find(params[:department]).lectures
			bar = []
			Classification.where(id: params['classification'].values).each do |c|
				bar += c.lectures
			end
			@lectures = foo & bar
		end

		@lecturetimes = []
		@classifications = []
		@professors = []

		@lectures.each do |l|
			@classifications << l.classification.classification_name
			@professors << (l.professor.nil? ? "unknown" : l.professor.professor_name)
			@lecturetimes << []
			l.lecturetimes.each do |t|
				@lecturetimes.last << t
			end
		end

		respond_to do |format|
			format.json { render :json => [@lectures,@lecturetimes,@classifications,@professors].to_json }
		end
	end

	def update_timetable
		@event = params[:evnt]
		@lecture = Lecture.find(params[:lecture_id])
		@grade = @lecture.grade
		lecture_time = @lecture.lecturetimes

		@days = lecture_time.collect{ |x| x[:day] }
			#when 1 ; "월" when 2 ; "화" when 3 ; "수" when 4 ; "목"
			#when 5 ; "금" when 6 ; "토" else "일" end }

		@times = []
		lecture_time.each do |t|
			@times << [t.starttime/100 * 100 + t.starttime%100 * 100/60, t.endtime/100 * 100 + t.endtime%100 * 100/60]
		end
		
		respond_to do |format|
			format.js
		end
	end
end
