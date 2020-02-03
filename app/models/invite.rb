class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :invite_status
end
