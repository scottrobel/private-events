require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest 
  test 'new method directs to sign up form' do
    get signup_path
    assert_select 'input[name=?]', 'user[username]'
    assert_select 'input[name=?]', 'user[bio]'
    assert_select 'input[name=?]', 'user[password]'
    assert_select 'input[name=?]', 'user[password_confirmation]'
  end
end
