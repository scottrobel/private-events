class InvitesController < ApplicationController
  include EventsHelper
  include InvitesHelper
  before_action :require_login
  before_action :require_invited, only: [:update]
  before_action :require_valid_response, only: [:update]
  def create
    event = Event.find_by(id: params[:invites][:id])
    selected_users = User.where(id: params[:invites][:users])
    already_invited_users = event.invited_users
    new_invites = selected_users - already_invited_users
    event.pending_attendees << new_invites
    flash[:success] = "Invites Sent"
    redirect_to event_path(event, tab: :pending_users)
  end

  def update
    @invite.status = params[:response]
    @invite.save
    if params[:response] == 'accepted'
      flash[:success] = "You have accepted this Event"
      redirect_to event_path(params[:id])
    elsif params[:response] == 'declined'
      flash[:success] = "Event Declined!"
      redirect_to profile_path
    end
  end
end
