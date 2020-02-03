require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  def setup
    @invite = invites(:declined_invite)
    @invited_user = @invite.user
    @invite_event = @invite.event
    @invite_status = @invite.invite_status
  end

  test 'associations not nil' do
    assert_not_nil @invited_user
    assert_not_nil @invite_event
    assert_not_nil @invite_status
  end

  test 'associations from correct class' do
    assert_kind_of Invite, @invite
    assert_kind_of User, @invited_user
    assert_kind_of InviteStatus, @invite_status
  end

  test "presence validatons" do
    required_attributes = %w[user event invite_status]
    presence_validations_test(@invite, required_attributes)
  end
end
