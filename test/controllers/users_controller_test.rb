require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:party_monster)
    @user.password = 'password'
    @user.save
  end
  test 'new method directs to sign up form' do
    get signup_path
    assert_select 'input[name=?]', 'user[username]'
    assert_select 'textarea[name=?]', 'user[bio]'
    assert_select 'input[name=?]', 'user[password]'
    assert_select 'input[name=?]', 'user[password_confirmation]'
  end

  test 'create method' do
    # creates a user when attributes are valid
    assert_difference 'User.count', 1 do
        post signup_path, params: {user:{ username: 'scottyprobeljr',
      bio: 'Hi My name is scotty I love coding and spending time with friends',
      password: 'password', 'password_confirmation' => 'password'}}
    end
    assert_redirected_to profile_path
    follow_redirect!
  end

  test 'does not create a user when passwords does not match' do
    assert_difference 'User.count', 0 do
      post signup_path, params: {user:{ username: 'scottyprobeljr',
        bio: 'Hi My name is scotty I love coding and spending time with friends',
        password: 'password', 'password_confirmation' => 'NOT A MATCHING PASSWORD'}}
    end
  end

  test 'does not create a user when password confirmation missing' do
    assert_difference 'User.count', 1 do
        post signup_path, params: {user:{ username: 'scottyprobeljr',
      bio: 'Hi My name is scotty I love coding and spending time with friends',
      password: 'password'}}
    end
  end

  test 'require logged out for new and create' do
    #login 
    post login_path, params: {session:{ username: @user.username, password: 'password'}}
    follow_redirect!
    # redirects login page
    get login_path
    assert_redirected_to profile_path
    follow_redirect!
    #redirects create page
    post signup_path, params: {user:{ username: 'scottyprobeljr',
      bio: 'Hi My name is scotty I love coding and spending time with friends',
      password: 'password', 'password_confirmation' => 'password'}}
    assert_redirected_to profile_path
    assert_equal flash[:error], "You are already logged in!"
    follow_redirect!
  end
end
