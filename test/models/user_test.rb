require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      name: "Kunok",
      email: "kunokdev@test.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  # Validation tests

  test "user validation" do
    assert @user.valid?
  end

  # Name validation tests

  test "name presence" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "name minimum length" do
    @user.name = "a"
    assert_not @user.valid?
  end

  test "name maximum length" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  # Email validation tests

  test "email presence" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "unique email" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase # as well as case insensitive
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email maximum length" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "valid email" do
    valid_emails = %w[kunok@mail.cn KUN-OK@san.CA KUN_OK@ChAn.Cn kun.ok@son.san.jp kun+ana@na.na]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?
    end
  end

  test "invalid email" do
    invalid_emails = %w[kun@ok@ovo@ko kunok@lan @_@ kun#@sa.ca kunok@sa!ma]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?
    end
  end

  # Password tests

  test "password presence" do
    @user.password = " " * 6
    assert_not @user.valid?
  end

  test "password minimum length" do
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # Digest
  test "not authenticated? if user has nil digest" do
    assert_not @user.authenticated?('')
  end

  # Delete user posts if user is deleted
  test "user destruction => user posts destruction" do
    @user.save
    @user.posts.create!(content: "Test post")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  # About tests

  test "about max length" do
    @user.about = 'a' * 201
    assert_not @user.valid?
  end

  test "about can be blank" do
    @user.about = " "
    assert @user.valid?
  end


end
