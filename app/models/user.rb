class User < ApplicationRecord
  future_event = ->{ where("time > ?", Time.now) }
  has_many :invites, class_name: 'Invite', dependent: :destroy
  has_many :events, through: :invites, source: :event
  has_many :pending_invites, ->{ where(invite_status_id: PendingInviteStatusId) }, class_name: 'Invite'
  has_many :accepted_invites, ->{ where(invite_status_id: AcceptedInviteStatusId) }, class_name: 'Invite'
  has_many :declined_invites, ->{ where(invite_status_id: DeclinedInviteStatusId) }, class_name: 'Invite'
  has_many :pending_events, through: :pending_invites, source: :event
  has_many :accepted_events, through: :accepted_invites, source: :event
  has_many :declined_events, through: :declined_invites, source: :event
  has_many :owned_events, class_name: 'Event', foreign_key: :event_organizer_id, dependent: :destroy
  validates :bio, :username, :profile_photo, presence: :true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }
  has_secure_password
  mount_uploader :profile_photo, AvatarUploader
end