require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @declined_user = users(:non_coder)
    @declined_user.password = 'password'
    @accepted_user = users(:coder)
    @accepted_user.password = 'password'
    @pending_user = users(:busy_guy)
    @pending_user.password = 'password'
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

  test 'bio and username present' do
    required_attributes = %w[bio username]
    presence_validations_test(@declined_user, required_attributes)
  end

  test 'password over 6 chars' do
    assert @declined_user.valid?
    @declined_user.password = 'a' * 5
    assert_not @declined_user.valid?
    @declined_user.password = 'password'
    assert @declined_user.valid?
  end

  test 'owned_events attribute' do
    host = users(:party_monster)
    #returns any object
    assert_equal host.owned_events.count, 1
    #returns an event type
    assert_type_of Event, host.owned_events.first
    #returns the right event
    assert_equal events(:coding_party), host.owned_events.first
  end
end
