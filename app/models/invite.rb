class Invite < ApplicationRecord
  AcceptedInviteStatusId = InviteStatus.find_or_create_by(status: :accepted).id
  PendingInviteStatusId = InviteStatus.find_or_create_by(status: :pending).id
  DeclinedInviteStatusId = InviteStatus.find_or_create_by(status: :declined).id
  belongs_to :user
  belongs_to :event
  belongs_to :invite_status
  validates :user, :event, :invite_status, presence: :true
  def status=(status)
    case status
    when 'accepted'
      self.invite_status_id = AcceptedInviteStatusId
    when 'pending'
      self.invite_status_id = PendingInviteStatusId
    when 'declined'
      self.invite_status_id = DeclinedInviteStatusId 
    end
  end
end