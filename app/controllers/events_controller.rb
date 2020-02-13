class EventsController < ApplicationController
  include EventsHelper
  before_action :require_login, only:[:new, :create]
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.event_organizer = current_user
    @event.time = selected_date
    if @event.save
      flash[:success] = "Event Created"
      redirect_to @event
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    if params[:tab] == 'create_invites'
      @display_invite_form = true
      @all_users = User.all
    else
      @invited_users = invited_users(@event, params[:tab])
    end
  end

  private

  def selected_date
    datetime_array = params.require(:datetime).permit(:year, :month, :day, :hour, :minute).values.map(&:to_i)
    DateTime.new(*datetime_array)
  end

  def event_params
    params.require(:event).permit(:title, :event_photo, :description, :location, :time)
  end

  private

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
end
