class JoinQuizService
  def initialize(quiz, user, broadcast_channel = QuizChannel)
    @quiz = quiz
    @user = user
    @broadcast_channel = broadcast_channel
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
    @broadcast_channel.broadcast_to(@quiz, {
      action: 'add_participant',
      participant: @user.name,
      participation: participation,
      participation_count: @quiz.participations.size
    })
  end
end
