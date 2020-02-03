require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:coding_party)
  end

  test "Events event_organizer attribute points to the right user" do
    event_organizer = users(:party_monster)
    assert_equal @event.event_organizer, event_organizer
  end

  test "invited_users attribute" do
    assert_count @event.invited_users, 3
  end
end
