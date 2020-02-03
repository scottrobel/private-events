module SessionsHelper
  private
  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def login_as(user)
    @user = user
    session[:user_id] = user.id
  end

  def logout
    @user = nil
    session.delete(:user_id)
  end
end
