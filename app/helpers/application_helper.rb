module ApplicationHelper
  private
  def navbar_link_class(link)
    if request.fullpath == link
      'active'
    else
      ''
    end
  end

  def event_tab_link_class(link)
    if request.fullpath == link
      'current-event-tab'
    else
      ''
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
    else
      []
    end
  end

  def navbar_link(text, link, html_params={})
    html_params[:class] = navbar_link_class(link)
    link_to text, link, html_params
  end

  def event_tab_link(text, link, html_params={})
    html_params[:id] = event_tab_link_class(link)
    link_to text, link, html_params
  end
end
