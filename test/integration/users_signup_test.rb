require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
        name: "",
        email: "invalid@email",
        password: "foo",
        password_confirmation: "bar"
      }
    end
    assert_template 'users/new'
  end

  test "valid signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
        name: "Kunok",
        email: "kunok774@test.com",
        password: "kenter",
        password_confirmation: "kenter"
      }
    end
    assert_template 'users/show'
  end

end
