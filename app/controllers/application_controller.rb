class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper


  private
    # Confirms a logged-in user.
    def check_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
