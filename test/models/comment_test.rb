require 'test_helper'

class CommentTest < ActiveSupport::TestCase


  test "valid comment" do
    @comment = Comment.new(
      content: "a" * 200
    )
    assert @comment.valid?
  end

  test "comment presence" do
    @comment = Comment.new(
      content: ""
    )
    assert_not @comment.valid?
  end

  test "comment max length" do
    @comment = Comment.new(
      content: "a" * 201
    )
    assert_not @comment.valid?
  end

end
