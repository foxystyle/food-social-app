class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper


  private

    # Confirm logged user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Log in required"
        redirect_to login_url
      end
    end


end
