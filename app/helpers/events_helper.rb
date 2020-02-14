module EventsHelper
  private
  def require_attendee
    unless Event.find_by(id: params[:id]) &. attendees &. include?(current_user)
      redirect_to profile_path
    end
  end

  def selected_date
    datetime_array = params.require(:datetime).permit(:year, :month, :day, :hour, :minute).values.map(&:to_i)
    DateTime.new(*datetime_array)
  end

  def event_params
    params.require(:event).permit(:title, :event_photo, :description, :location, :time)
  end

  def require_tab
    if params[:tab] == nil
      redirect_to event_path(params[:id], tab: :accepted_users)
    end
  end

  def invited_users(event, tab)
    case tab
    when 'accepted_users'
      event.attendees
    when 'pending_users'
      event.pending_attendees
    when 'declined_users'
      event.non_attendees
    when nil
      event.attendees
    else
      []
    end
  end

  def require_exists
    unless Event.find_by(id: params[:id])
      flash[:error] = "This event does not exist"
      redirect_to profile_path
    end
  end
end
