class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.encrypted[:user_id] = { value: user.id, expires: 1.month.from_now }
      user.appear # Trigger real-time broadcast immediately
      redirect_to rooms_path, notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid name or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.disappear if current_user
    session[:user_id] = nil
    cookies.delete(:user_id)
    redirect_to root_path, notice: "Logged out!"
  end
end
