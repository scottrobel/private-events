class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :invite_status
  validates :user, :event, :invite_status, presence: :true
end
