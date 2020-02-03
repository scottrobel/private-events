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
    assert attendees.any?
    #returns the right type of objects
    assert_kind_of User, attendees.first
    #returns a user that has an accepted invite to the event
    attendees.each do |attendee|
      users_invite = Invite.find_by(user_id: attendee.id, event_id: @event.id)
      assert_not_nil users_invite
      assert users_invite.invite_status.status == 'accepted'
    end
  end

  test "non_attendees attribute" do
    attendees = @event.non_attendees
    #returns any objects to test
    assert attendees.any?
    #returns the right type of objects
    assert_kind_of User, attendees.first
    #returns a user that has an declined invite to the event
    attendees.each do |attendee|
      users_invite = Invite.find_by(user_id: attendee.id, event_id: @event.id)
      assert_not_nil users_invite
      assert users_invite.invite_status.status == 'declined'
    end
  end

  test "pending_attendees attribute" do
    attendees = @event.pending_attendees
    #returns any objects to test
    assert attendees.any?
    #returns the right type of objects
    assert_kind_of User, attendees.first
    #returns a user that has an pending invite to the event
    attendees.each do |attendee|
      users_invite = Invite.find_by(user_id: attendee.id, event_id: @event.id)
      assert_not_nil users_invite
      assert users_invite.invite_status.status == 'pending'
    end
  end

  test "presence validatons" do
    required_attributes = %w[title event_photo description location time event_organizer]
    required_attributes.each do |attribute|
      assert @event.valid?
      original_attribute_value = @event.send(attribute)
      @event.send("#{attribute}=", nil)
      assert_not @event.valid?
      assert @event.errors[attribute.to_sym].include?("can't be blank")
      @event.send("#{attribute}=", original_attribute_value)
      assert @event.valid?
    end
  end
end
