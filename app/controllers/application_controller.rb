class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authenticate_user!

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      # Ensure encrypted cookie is set for Action Cable
      if @current_user && cookies.encrypted[:user_id].nil?
        cookies.encrypted[:user_id] = session[:user_id]
      end
    end
    @current_user
  end

  def authenticate_user!
    redirect_to login_path, alert: "You must be logged in to access this page" unless current_user
  end
end
