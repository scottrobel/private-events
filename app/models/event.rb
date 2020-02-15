class Event < ApplicationRecord
  AcceptedInviteStatusId = InviteStatus.find_or_create_by(status: :accepted).id
  PendingInviteStatusId = InviteStatus.find_or_create_by(status: :pending).id
  DeclinedInviteStatusId = InviteStatus.find_or_create_by(status: :declined).id
  scope :past, ->{ where("time < ?", Time.now) }
  scope :future, ->{ where("time > ?", Time.now) }
  belongs_to :event_organizer, class_name: 'User', foreign_key: 'event_organizer_id'
  has_many :invites, dependent: :destroy
  has_many :invited_users, through: :invites, source: 'user'
  has_many :accepted_invites, ->{where(invite_status_id: AcceptedInviteStatusId)}, class_name: 'Invite'
  has_many :attendees, through: :accepted_invites, source: 'user'
  has_many :pending_invites, ->{where(invite_status_id: PendingInviteStatusId)}, class_name: 'Invite'
  has_many :pending_attendees, through: :pending_invites, source: 'user'
  has_many :declined_invites, ->{where(invite_status_id: DeclinedInviteStatusId)}, class_name: 'Invite'
  has_many :non_attendees, through: :declined_invites, source: 'user'
  validates :title, :event_photo, :description, :location, :time, :event_organizer, presence: true
  mount_uploader :event_photo, AvatarUploader
  future_event = ->{ where("time > ?", Time.now) }
end
