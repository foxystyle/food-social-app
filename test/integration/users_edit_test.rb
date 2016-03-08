require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kunok)
  end

  test "unsucessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {
      name: "",
      email: "invalid@email",
      about: "",
      password: "foo",
      password_confirmation: "bar"
    }
    assert_template 'users/edit'
  end

  test "sucessful edit + friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Name test"
    email = "valid@email.test"
    patch user_path(@user), user: {
      name: name,
      email: email,
      about: "",
      password: "",
      password_confirmation: ""
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end
