class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_as(@user)
      flash[:success] = "Signup Successfull!"
      redirect_to profile_path
    else
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :bio, :password, :password_confirmation, :photo, :profile_photo)
  end
end
