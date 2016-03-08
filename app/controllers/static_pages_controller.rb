class StaticPagesController < ApplicationController

  def index
    @user = current_user
    @post = current_user.posts.build if logged_in?
  end


end
