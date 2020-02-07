require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'must be logged in to create event' do
    get new_event_path
    assert_redirected_to login_path
    follow_redirect!
  end
end
