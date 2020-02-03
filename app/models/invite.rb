class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :invite_status
  %w[user event invite_status].each do |attribute|
    validates attribute.to_sym, presence: :true
  end
end
