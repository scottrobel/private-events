class SessionsController < ApplicationController
  def new ; end
  def create
    user = User.find_by(username: params[:session][:username])
    if user
      if user.authenticate(params[:session][:password])
        login_as(user)
        flash[:success] = "Welcome #{user.username}! You are now Logged In"
        redirect_to profile_path
      else
        flash.now[:error] = "Incorrect Password"
        render :new
      end
    else
      flash.now[:error] = "That Username Is not registered with this website"
      render :new
    end
  end
  def destroy
    logout
    flash[:success] = "You are now logged out!"
    redirect_to login_path
  end
end
