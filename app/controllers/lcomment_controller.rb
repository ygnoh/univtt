class LcommentController < ApplicationController
    def lcommentshow
        @lecture = Lecture.find(params[:lecture_id])
    end
  
    def createlcomment
        comment = Lcomment.new
        comment.user_id = current_user.id
        comment.lecture_id = params[:lecture_id]
        comment.content = params[:lcomment]
        if comment.save
            flash[:success] = "작성 되었습니다."
            redirect_to "/lcomment/lcommentshow/#{comment.lecture.id}"
        else
            flash[:error] = "작성에 실패하였습니다."
            redirect_to "/lcomment/lcommentshow/#{comment.lecture.id}"
        end
    end
    
    def deletelcomment
        comment = Lcomment.find(params[:lcomment_id])
        if comment.user!=current_user
            flash[:error] = "삭제 권한이 없습니다."
            redirect_to "/lcomment/lcommentshow/#{comment.lecture.id}"
        else
            comment.destroy
            flash[:success] = "삭제 되었습니다."
            redirect_to "/lcomment/lcommentshow/#{comment.lecture.id}"
        end
    end
end
