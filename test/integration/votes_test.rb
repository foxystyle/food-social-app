require 'test_helper'

class UserVoteTestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:kunok)
    @post = posts(:food)
  end

  def go_to_post(logged = false)
    log_in_as @user if logged
    get post_path @post
    assert_template 'posts/show'
  end

  test "display upvote if logged in" do
    go_to_post true
    assert_select 'a[href=?]', upvote_post_path(@post)
  end

  test "do not display upvote if not logged in" do
    go_to_post
    assert_select 'a[href=?]', upvote_post_path(@post), count: 0
  end

end
