require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kunok)
    @other_user = users(:john)
  end

  test "user profile with posts" do
    get user_path @user
    assert_template 'users/show'
    assert_select 'div.post'
  end

  test "user profile without posts" do
    get user_path @other_user
    assert_template 'users/show'
    assert_select 'div.post', count: 0
  end

end
