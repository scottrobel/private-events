require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:coding_party)
    @event_organizer = users(:party_monster)
  end

  test "Events event_organizer attribute points to the right user" do
    assert_equal @event.event_organizer, @event_organizer
  end

  test "invited_users attribute" do
    assert_equal @event.invited_users.count, 3
    assert_equal @event.invited_users.first.class, User.new.class
  end
end
