class Event < ApplicationRecord
  belongs_to :event_organizer, class_name: 'User', foreign_key: 'event_organizer_id'
  has_many :invites
  has_many :invited_users, through: :invites, source: 'user'
  has_many :accepted_invites, ->{where(invite_status_id: AcceptedInviteStatusId)}, class_name: 'Invite'
  has_many :attendees, through: :accepted_invites, source: 'user'
  has_many :pending_invites, ->{where(invite_status_id: PendingInviteStatusId)}, class_name: 'Invite'
  has_many :pending_attendees, through: :pending_invites, source: 'user'
  has_many :declined_invites, ->{where(invite_status_id: DeclinedInviteStatusId)}, class_name: 'Invite'
  has_many :non_attendees, through: :declined_invites, source: 'user'
  %w[title event_photo description location time event_organizer].each do |attribute|
    validates attribute.to_sym, presence: true
  end
end
