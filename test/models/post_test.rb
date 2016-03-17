require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:kunok)
    @post = @user.posts.build(content: "Test content")
  end

  test "valid post" do
    assert @post.valid?
  end

  test "user_id presence" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content presence" do
    @post.content = " "
    assert_not @post.valid?
  end

  test "max length" do
    @post.content = 'a' * 201
    assert_not @post.valid?
  end

  test "order by recent" do
    assert_equal posts(:most_recent), Post.first
  end

end
