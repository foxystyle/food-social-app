require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kunok)
  end

  test "invalid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: "", password: ""}
    assert_template 'sessions/new'
    assert_not flash.empty?
    # Check if flash is gone after visiting other page...
    get root_path
    assert flash.empty?
  end

  test "valid login" do
    # Log in first...
    get login_path
    post login_path, session: {email: @user.email, password: 'password'}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # Check if links are displayed properly...
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "logout" do
    # Log in first...
    get login_path
    post login_path, session: {email: @user.email, password: 'password'}
    # Now log out...
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    # Check if links are displaying properly...
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    # Logout in a different window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
  end


end
