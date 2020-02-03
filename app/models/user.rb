class User < ApplicationRecord
  has_many :pending_invites, ->{ where(invite_status_id: PendingInviteStatusId) }, class_name: 'Invite'
  has_many :accepted_invites, ->{ where(invite_status_id: AcceptedInviteStatusId) }, class_name: 'Invite'
  has_many :declined_invites, ->{ where(invite_status_id: DeclinedInviteStatusId) }, class_name: 'Invite'
  has_many :pending_events, through: :pending_invites, source: :event
  has_many :accepted_events, through: :accepted_invites, source: :event
  has_many :declined_events, through: :declined_invites, source: :event
  has_many :owned_events, class_name: 'Event', foreign_key: :event_organizer_id
  %w[bio username].each do |attribute|
    validates attribute.to_sym, presence: :true
  end
  validates :password, length: { minimum: 6 }
  has_secure_password
end
