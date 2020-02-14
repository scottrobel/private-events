module SessionsHelper
  private

  def users_events(tab)
    case tab
    when 'accepted_events'
      current_user.accepted_events
    when 'pending_events'
      current_user.pending_events
    when 'declined_events'
      current_user.declined_events
    when nil
      current_user.pending_events
    end
    
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def login_as(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def logout
    @current_user = nil
    session.delete(:user_id)
  end

  def logged_in?
    !!current_user
  end

  def require_logged_out
    if logged_in?
      flash[:error] = "You are already logged in!"
      redirect_to profile_path
    end
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must Login to see that!"
      redirect_to login_path
    end
  end
end