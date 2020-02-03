require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:party_monster)
    @user.password = 'password'
    @user.save
  end

  test 'login page' do
    get login_path
    assert_select 'input[name=?]', 'session[username]'
    assert_select 'input[name=?]', 'session[password]'
    assert_select 'input[name=?]', 'commit'
  end

  test 'login functionality' do
    post login_path, params: {session:{ username: @user.username, password: 'password'}}
    assert_not flash.empty?
    post login_path, params: {session:{ username: @user.username, password: 'password'}}
    assert_redirected_to(profile_path)
    assert_not flash.empty?
  end

  test 'logout functionality' do
    delete logout_path
    assert_not flash.empty?
    assert_redirected_to(login_path)
  end

  test 'Profile page' do
    get profile_path
    user = assigns(:user)
    #exists
    assert_not_nil user
    #has user instance var
    assert_kind_of User, user
    assert 'h1', user.username
    assert 'p', user.bio
  end
end
