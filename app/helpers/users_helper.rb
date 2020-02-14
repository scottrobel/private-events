module UsersHelper
  private

  def not_own_profile
    if current_user == User.find_by(id: params[:id])
      redirect_to profile_path
    end
  end
end
