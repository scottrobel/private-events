module InvitesHelper
  def require_invited
    @invite = Invite.find_by(event_id: params[:id], user_id: current_user.id)
    unless @invite
      flash[:error] = "You are not invited to That Event"
      redirect_to root_path
    end
  end
  def require_valid_response
    unless %w[accepted declined].include?(params[:response])
      redirect_to profile_path(tab: :pending_events)
    end
  end
    
end
