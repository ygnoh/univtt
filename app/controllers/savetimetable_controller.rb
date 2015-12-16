class SavetimetableController < ApplicationController
	before_action :admin?

	def index
		@savetts = Savetimetable.all
	end

	def show
	end

	def edit
		flash[:error] = "아직 미구현 상태입니다."
		return redirect_to :back
	end

	def destroy
		savett = Savetimetable.find(params[:id])
		savett.active = false
		if savett.save
			flash[:success] = "성공적으로 삭제하였습니다."
			return redirect_to :back
		else
			flash[:error] = "삭제에 실패하였습니다."
			return redirect_to :back
		end
	end
end
