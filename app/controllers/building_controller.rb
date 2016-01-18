class BuildingController < ApplicationController
	before_action :admin?

	def index
		@buildings = Building.all
	end

	def show
		@building = Building.find(params[:id])
		@classrooms = @building.classrooms
	end

	def edit
		flash[:error] = "아직 미구현 상태입니다."
		return redirect_to :back
	end

	def destroy
		building = Building.find(params[:id])
		building.active = false
		if building.save
			flash[:success] = "성공적으로 삭제하였습니다."
			return redirect_to :back
		else
			flash[:error] = "삭제에 실패하였습니다."
			return redirect_to :back
		end
	end
end
