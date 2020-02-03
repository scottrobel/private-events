require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'login page' do
    get login_path
    assert_template 'sessions/new'
  end
end
