class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  AcceptedInviteStatusId = InviteStatus.find_or_create_by(status: :accepted)
  PendingInviteStatusId = InviteStatus.find_or_create_by(status: :pending)
  DeclinedInviteStatusId = InviteStatus.find_or_create_by(status: :declined)
end
