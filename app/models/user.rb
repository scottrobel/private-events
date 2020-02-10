class User < ApplicationRecord
  future_event = ->{ where("time > ?", Time.now) }
  has_many :pending_invites, ->{ where("invite_status_id = ?", InviteStatus.find_by(status: :pending).id) }, class_name: 'Invite'
  has_many :accepted_invites, ->{ where("invite_status_id = ?", InviteStatus.find_by(status: :pending).id) }, class_name: 'Invite'
  has_many :declined_invites, ->{ where("invite_status_id = ?", InviteStatus.find_by(status: :declined).id) }, class_name: 'Invite'
  has_many :pending_events, future_event, through: :pending_invites, source: :event
  has_many :accepted_events, future_event, through: :accepted_invites, source: :event
  has_many :declined_events, future_event, through: :declined_invites, source: :event
  has_many :owned_events, class_name: 'Event', foreign_key: :event_organizer_id
  validates :bio, :username, presence: :true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6 }
  has_secure_password
  mount_uploader :profile_photo, AvatarUploader
end
