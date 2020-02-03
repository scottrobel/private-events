require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:party_monster)
    @user.password = 'password'
  end

  test 'login page' do
    get login_path
    assert_select 'input[name=?]', 'session[username]'
    assert_select 'input[name=?]', 'session[password]'
    assert_select 'input[name=?]', 'commit'
  end

  test 'login functionality' do
    post login_path, params: { username: '', password: ''}
    assert_not flash[:error].empty?
    post login_path, params: { username: @user.username, password: 'password'}
    assert_redirected_to(profile_path)
  end
end
