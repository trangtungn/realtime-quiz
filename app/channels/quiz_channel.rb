class QuizChannel < ApplicationCable::Channel
  def subscribed
    p 'QuizChannel - subscribed'
    p params
    quiz = Quiz.find(params[:id])
    stream_for quiz
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    p 'QuizChannel - unsubscribed'
  end
end
