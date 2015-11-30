class PostController < ApplicationController
        before_action :authenticate_user!, except: [ :index, :show ]
  
  def index
    @posts = Post.page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:post_id])
    @post.view_count += 1
    if !@post.save
      flash[:error] = "view_count 저장 실패"
      redirect_to "/post/index"
    end
  end

  def new
    
  end
  
  def edit
   @post = Post.find(params[:post_id])
   if @post.user_id != current_user.id
     flash[:error] = "수정 권한이 없습니다."
     redirect_to "/post/index"
   end
  end

  def create
    post = Post.new
    post.user = current_user
    post.view_count = 0
    post.title = params[:title]
    post.content = params[:content]
     if post.save
      flash[:success] = "작성 되었습니다."
      redirect_to "/post/show/#{post.id}"
     else
      flash[:error] = "작성에 실패하였습니다."
      redirect_to "/post/index"
     end
  end
  
  def update
    post = Post.find(params[:id])
    post.title = params[:title]
    post.content = params[:content]   
    if post.save
      flash[:success] = "수정 되었습니다."
      redirect_to "/post/show/#{post.id}"
    else
      flash[:error] = "수정에 실패하였습니다."
      redirect_to :back
    end
  end

  def destroy
    post = Post.find(params[:post_id])
     if post.user!=current_user
        flash[:error] = "삭제 권한이 없습니다."
        redirect_to "/post/index"
     else
       post.destroy
       flash[:success] = "삭제 되었습니다."
       redirect_to "/post/index"
     end
  end
  
  def createpcomment
    comment = Pcomment.new
    comment.user_id = current_user.id
    comment.post_id = params[:post_id]
    comment.content = params[:pcomment]
    if comment.save
      flash[:success] = "작성 되었습니다."
      redirect_to "/post/show/#{comment.post.id}"
    else
      flash[:error] = "작성에 실패하였습니다."
      redirect_to "/post/show/#{comment.post.id}"
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.re g quire(:post).permit(:title, :content, :user_id)
    end
    

end
