class QuizChannel < ApplicationCable::Channel
  def subscribed
    quiz = Quiz.find(params[:id])
    stream_for quiz
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    logger.info "Client unsubscribed from quiz channel"
  end
end
