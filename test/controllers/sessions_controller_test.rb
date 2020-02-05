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
    post login_path, params: {session:{ username: @user.username, password: 'password'}}
    get profile_path
    #exists
    user = assigns(:user)
    assert_not_nil user
    #has user instance var
    assert_kind_of User, user
    #page contains user info
    assert_select 'h1', user.username
    assert_select 'p', user.bio
  end

  test 'navbar' do
    post login_path, params: {session:{ username: @user.username, password: 'password'}}
    get profile_path
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', profile_path
    delete logout_path
    follow_redirect!
    assert_select 'a[href=?]', login_path
  end

  test 'logged in users get redirected to profile page when they visit /login or submit to /login' do
    post login_path, params: {session:{ username: @user.username, password: 'password'}}
    #redirects logged in users to profile page when they goto the login page
    get login_path
    assert_redirected_to profile_path

    assert_equal "You are already logged in!", flash[:error]
    follow_redirect!
    #redirects when you try and submit login and are already logged in
    post login_path, params: {session:{ username: @user.username, password: 'password'}}
    assert_redirected_to profile_path
    assert_equal "You are already logged in!", flash[:error]
    follow_redirect!
    delete logout_path
  end

  test 'require_login for profile_path and logout_path' do
    get profile_path
    assert_redirected_to login_path
    assert_equal "You must Login to see that!", flash[:error]
    follow_redirect!
    delete logout_path
    assert_redirected_to login_path
    assert_equal "You must Login to see that!", flash[:error]
  end
end
