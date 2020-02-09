class EventsController < ApplicationController
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
      #redirect_to @event
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
end
