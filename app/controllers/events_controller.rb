class EventsController < ApplicationController
  include EventsHelper
  before_action :require_login, only:[:new, :create, :show]
  before_action :require_exists, only: [:show]
  before_action :require_attendee, only: [:show]
  before_action :require_tab, only: [:show]
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.event_organizer = current_user
    @event.time = selected_date
    if @event.save
      @event.attendees << current_user
      flash[:success] = "Event Created"
      redirect_to event_path(@event.id, tab: :accepted_users)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    if params[:tab] == 'create_invites'
      @display_invite_form = true
      @all_users = User.all - @event.invited_users
    else
      @invited_users = invited_users(@event, params[:tab])
    end
  end
end
