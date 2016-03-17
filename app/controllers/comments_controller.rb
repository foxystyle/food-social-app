class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash[:success] = @comment
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_to @post
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
