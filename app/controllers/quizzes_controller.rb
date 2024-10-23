class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :prepare_quiz, only: [:show, :join]

  def index
    @quizzes = Quiz.all
  end

  def show
    @participations = @quiz.participations
    @joined = @quiz.participations.exists?(user: current_user)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: "Quiz was successfully created." }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
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
    @quiz = Quiz.find(params[:id])

    check_expiration
  end

  def check_expiration
    return unless @quiz.token_expired?

    flash[:alert] = "This quiz has ended."
    redirect_to quizzes_path
  end

  def quiz_params
    params.require(:quiz).permit(:title, :description)
  end
end
