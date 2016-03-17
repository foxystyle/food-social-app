class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build()
    if @comment.save
      flash[:success] = "Comment saved"
      redirect_to @post
    else
      render :newa
    end
  end
end
