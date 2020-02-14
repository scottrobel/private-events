class InvitesController < ApplicationController
  include EventsHelper
  before_action :require_attendee, only: [:created]
  def create
    event = Event.find_by(id: params[:invites][:id])
    selected_users = User.where(id: params[:invites][:users])
    already_invited_users = event.invited_users
    new_invites = selected_users - already_invited_users
    event.pending_attendees << new_invites
    flash[:success] = "Invites Sent"
    redirect_to event_path(event)
  end
end
