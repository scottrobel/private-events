class InviteStatus < ApplicationRecord
  %w[status].each do |attribute|
    validates attribute.to_sym, presence: :true
  end
end
