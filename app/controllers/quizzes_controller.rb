class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :prepare_quiz, only: [:show, :join]
  before_action :validate_quiz, only: :join

  def index
    @quizzes = Quiz.all.order(created_at: :asc)
  end

  def show
    @presenter = QuizPresenter.new(@quiz, current_user)
  end

  def join
    @participation = @quiz.participations.create(user: current_user)
    @participation_count = @quiz.participations.size

    QuizChannel.broadcast_to(@quiz, { action: 'add_participant', participant: current_user.name, participation: @participation, participation_count: @participation_count })

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @quiz, notice: "You have joined the quiz." }
    end
  end

  private

  def prepare_quiz
    @quiz = Quiz.find_by!(token: params[:token])
  end

  def validate_quiz
    return unless @quiz.expired?

    respond_to do |format|
      format.html { redirect_to quizzes_path, alert: "This quiz has ended." }
      format.turbo_stream { head :unprocessable_entity }
    end
  end

  def quiz_params
    params.require(:quiz).permit(:title, :description)
  end
end
