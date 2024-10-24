class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :prepare_quiz, only: [:show, :join]
  before_action :validate_quiz, only: :join

  def index
    @quizzes = Quiz.all
  end

  def show
    @participations = @quiz.participations
    @joined = @quiz.participations.exists?(user: current_user)
  end

  def join
    @quiz = Quiz.find_by!(unique_id: params[:unique_id])
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
    return unless @quiz.token_expired?

    flash[:alert] = "This quiz has ended."
    redirect_to quizzes_path
  end

  def quiz_params
    params.require(:quiz).permit(:title, :description)
  end
end
