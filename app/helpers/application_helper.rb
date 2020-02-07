module ApplicationHelper
  private
  def navbar_link_class(link_helper)
    if request.fullpath == link_helper
      'active'
    else
      ''
    end
  end

  def navbar_link(text, link, params={})
    params[:class] = navbar_link_class(link)
    link_to text, link, params
  end
end
