class DepartmentController < ApplicationController
	before_action :admin?
	
	def index
		@departments = Department.all
	end

	def show
		@school = School.find(params[:id])
		@departments = @school.departments
	end

	def edit
		flash[:error] = "아직 미구현 상태입니다."
		return redirect_to :back
	end

	def destroy
		department = Department.find(params[:id])
		department.active = false
		if department.save
			flash[:success] = "성공적으로 삭제하였습니다."
			return redirect_to :back
		else
			flash[:error] = "삭제에 실패하였습니다."
			return redirect_to :back
		end
	end
end
