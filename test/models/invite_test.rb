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
end
