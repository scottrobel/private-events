class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_login, only: [:destroy, :show]
  before_action :require_profile_tab, only: [:show]
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

  def show
    @user = current_user
    @events = users_events(params[:tab])
    render 'sessions/show'
  end
end
