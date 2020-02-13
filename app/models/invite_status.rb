class InviteStatus < ApplicationRecord
  validates :status, presence: :true
end
