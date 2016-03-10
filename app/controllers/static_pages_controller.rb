class StaticPagesController < ApplicationController

  def index
    if logged_in?
      @user = current_user
      @post = current_user.posts.build
    end
  end


end
