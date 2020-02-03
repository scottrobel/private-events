require 'test_helper'

class InviteStatusTest < ActiveSupport::TestCase
  def setup
    @invite_status = invite_statuses(:accepted)
  end

  test 'presence validations' do
    required_attributes = %w[status]
    presence_validations_test(@invite_status, required_attributes)
  end
end
