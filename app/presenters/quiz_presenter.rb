class QuizPresenter
  attr_reader :quiz, :current_user

  def initialize(quiz, current_user)
    @quiz = quiz
    @current_user = current_user
  end

  def participations
    @participations ||= quiz.participations
  end

  def joined?
    @joined ||= participations.exists?(user: current_user)
  end

  def ended?
    @ended ||= quiz.expired?
  end
end
