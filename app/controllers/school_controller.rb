class SchoolController < ApplicationController
	before_action :admin?

	def index
		@schools = School.all
	end

	def edit
		flash[:error] = "아직 미구현 상태입니다."
		return redirect_to :back
	end

	def destroy
		school = School.find(params[:id])
		school.active = false
		if school.save
			flash[:success] = "성공적으로 삭제하였습니다."
			return redirect_to :back
		else
			flash[:error] = "삭제에 실패하였습니다."
			return redirect_to :back
		end
	end
end
