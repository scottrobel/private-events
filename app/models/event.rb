class Event < ApplicationRecord
  belongs_to :event_organizer, class_name: 'User', foreign_key: 'event_organizer_id'
  has_many :invites
  has_many :invited_users, through: :invites, source: 'user'
end
