require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @post = posts(:food)
  end

  test "redirect create if not logged in" do
    assert_no_difference "Post.count" do
      post :create, post: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "redirect destroy if not logged in" do
    assert_no_difference "Post.count" do
      delete :destroy, id: @post
    end
    assert_redirected_to login_url
  end




end
