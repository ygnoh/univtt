class UserController < ApplicationController
	before_action :admin?
	
  def index
		@users = User.all
  end

	def edit
		flash[:error] = "아직 미구현 상태입니다."
		return redirect_to :back
	end

	def destroy
		user = User.find(params[:id])
		if user.admin?
			flash[:error] = "해당 유저는 삭제가 불가능합니다."
			return redirect_to :back
		end

		user.active = false
		if user.save
			flash[:success] = "성공적으로 삭제하였습니다."
			return redirect_to :back
		else
			flash[:error] = "삭제에 실패하였습니다."
			return redirect_to :back
		end
	end
end
