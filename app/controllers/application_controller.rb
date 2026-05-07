class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authenticate_user!

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      # Always sync encrypted cookie with session to prevent stale IDs
      if @current_user && cookies.encrypted[:user_id] != session[:user_id]
        Rails.logger.info "SYNCING CABLE COOKIE for user: #{@current_user.name}"
        cookies.encrypted[:user_id] = { value: session[:user_id], expires: 1.month.from_now }
      end
    end
    @current_user
  end

  def authenticate_user!
    redirect_to login_path, alert: "You must be logged in to access this page" unless current_user
  end
end
