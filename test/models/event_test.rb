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

  test "attendees attribute" do
    attendees = @event.attendees
    #returns any objects to test
    assert attendees.count.any?
    #returns the right type of objects
    assert_kind_of attendees.first, User
    #returns a user that has an accepted invite to the event
    attendees.each do |attendee|
      assert_not_nil Invite.find_by(user_id: attendee.id, event_id: @event.id)
    end
  end
end
