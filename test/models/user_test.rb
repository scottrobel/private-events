require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @declined_user = users(:non_coder)
    @accepted_user = users(:coder)
    @pending_user = users(:busy_guy)
  end

  test 'declined_user has 1 declined_events' do
    assert_equal @declined_user.declined_events.count, 1
  end

  test 'pending_user has 1 pending_event' do
    assert_equal @pending_user.pending_events.count, 1
  end

  test 'accepted_user has 1 accepted_event' do
    assert_equal @accepted_user.accepted_events.count, 1
  end
end
