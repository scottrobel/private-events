class Event < ApplicationRecord
  belongs_to :event_organizer, class_name: 'User', foreign_key: 'event_organizer_id'
  has_many :invites
  has_many :invited_users, through: :invites, source: 'user'
  has_many :accepted_invites, ->{where("invite_status_id = ?", InviteStatus.find_by(status: :accepted).id)}, class_name: 'Invite'
  has_many :attendees, through: :accepted_invites, source: 'user'
  has_many :pending_invites, ->{where("invite_status_id = ?", InviteStatus.find_by(status: :pending).id)}, class_name: 'Invite'
  has_many :pending_attendees, through: :pending_invites, source: 'user'
  has_many :declined_invites, ->{where("invite_status_id = ?", InviteStatus.find_by(status: :declined).id)}, class_name: 'Invite'
  has_many :non_attendees, through: :declined_invites, source: 'user'
  validates :title, :event_photo, :description, :location, :time, :event_organizer, presence: true
  mount_uploader :event_photo, AvatarUploader
end
