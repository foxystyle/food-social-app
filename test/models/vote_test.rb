require 'test_helper'

class VoteTest < ActiveSupport::TestCase

  def setup
    @vote = Vote.new
  end

  test "valid vote score" do
    @vote.score = 1
    assert @vote.valid?
    @vote.score = -1
    assert_not @vote.valid?
  end

  test "invalid vote score" do
    @vote.score = 2
    assert_not @vote.valid?
  end

end
