module EventsHelper
  private
  def invited_users(event, tab)
    case tab
    when 'accepted_users'
      event.attendees
    when 'pending_users'
      event.pending_attendees
    when 'declined_users'
      event.non_attendees
    else
      []
    end
  end
end
