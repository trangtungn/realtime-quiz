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
    @participation = @quiz.participations.new(user: current_user)

    if @participation.save
      @participation_count = @quiz.participations.size
      QuizChannel.broadcast_to(@quiz, {
        action: 'add_participant',
        participant: current_user.name,
        participation: @participation,
        participation_count: @participation_count
      })

      message = "You have joined the quiz."
      respond_to do |format|
        format.turbo_stream { render :join, locals: { notice: message } }
        format.html { redirect_to @quiz, notice: message }
      end
    else
      message = @participation.errors.full_messages.to_sentence
      respond_to do |format|
        format.turbo_stream { render :join, locals: { alert: message } }
        format.html { render :show, status: :unprocessable_entity }
      end
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
