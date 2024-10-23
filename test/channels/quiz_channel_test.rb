require "test_helper"

class QuizChannelTest < ActionCable::Channel::TestCase
  test "subscribes and stream for quiz" do
    subscribe quiz_id: "15"

    assert subscription.confirmed?
    assert_has_stream "quiz_15"
  end
end
