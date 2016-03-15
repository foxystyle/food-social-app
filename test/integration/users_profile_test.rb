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

 test "user profile links" do
   get user_path @user
   assert_template 'users/show'
   assert_select 'a[href=?]', edit_user_path
 end

 test "shouldn't show post form for foreign users" do
   log_in_as @other_user
   get user_path @user
   assert_template 'users/show'
   assert_select 'textarea', count: 0
 end

end
