class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :invite_status
  validates :user, :event, :invite_status, presence: :true

  def status=(status)
    case status
    when :accepted
      invite_status_id = AcceptedInviteStatusId
    when :pending
      invite_status_id = PendingInviteStatusId
    when :declined
      invite_status_id = DeclinedInviteStatusId 
    end
  end
end
