class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  AcceptedInviteStatusId = InviteStatus.find_or_create_by(status: :accepted).id
  PendingInviteStatusId = InviteStatus.find_or_create_by(status: :pending).id
  DeclinedInviteStatusId = InviteStatus.find_or_create_by(status: :declined).id
end
