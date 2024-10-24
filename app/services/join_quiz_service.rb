class JoinQuizService
  def initialize(quiz, user)
    @quiz = quiz
    @user = user
  end

  def call
    participation = @quiz.participations.new(user: @user)

    if participation.save
      broadcast_message(participation)

      { success: true, message: "You have joined the quiz." }
    else
      { success: false, message: participation.errors.full_messages.to_sentence }
    end
  end

  private

  def broadcast_message(participation)
    QuizChannel.broadcast_to(@quiz, {
      action: 'add_participant',
      participant: @user.name,
      participation: participation,
      participation_count: @quiz.participations.size
    })
  end
end
