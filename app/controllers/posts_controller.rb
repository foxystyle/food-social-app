class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :update]

  def show
    @post = Post.find(params[:id])
    @edits = @post.edits
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'static_pages/index'
    end
  end

  def edit
    @post = current_post
  end

  def update
    @post = current_post
    @content = current_post.content
    @edit = Edit.new(
      content: @content,
      post_id: @post.id
    )
    if @post.update_attributes(post_params) && @edit.save
      flash[:success] = "Edit successful"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = current_post
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

    def correct_user
      @post = current_post
      redirect_to root_url if @post.nil?
    end

    def current_post
      current_user.posts.find_by(id: params[:id])
    end

end
