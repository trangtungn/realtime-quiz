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
    result = JoinQuizService.new(@quiz, current_user).call

    respond_to do |format|
      if result[:success]
        format.turbo_stream { render :join, locals: { status: :success, message: result[:message] } }
        format.html { redirect_to @quiz, success: result[:message] }
      else
        format.turbo_stream { render :join, locals: { status: :error, message: result[:message] } }
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
      format.turbo_stream { render :join, locals: { status: :error, message: "This quiz has ended." } }
    end
  end
end
