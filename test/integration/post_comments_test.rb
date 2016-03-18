require 'test_helper'

class PostCommentsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kunok)
    @post = posts(:food)
  end

  def go_to_post(logged = false)
    log_in_as @user if logged
    get post_path @post
    assert_template 'posts/show'
  end

  test "shouldn't see comment form unless logged in" do
    go_to_post
    assert_select 'textarea', count: 0
  end

  test "should see comment form if logged in" do
    go_to_post true
    assert_select 'textarea'
  end

  test "if 1 comment exits, 1 comment div should be printed" do
    go_to_post true
    assert @post.comments.count == 1 # pass
    assert_select 'div.comment', count: 1 # failure
  end

end
