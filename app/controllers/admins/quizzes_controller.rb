module Admins
  class QuizzesController < BaseController
    before_action :prepare_quiz, only: :show

    def new
      @quiz = Quiz.new
    end

    def create
      @quiz = current_user.created_quizzes.build(quiz_params)

      if @quiz.save
        redirect_to admins_quiz_path(@quiz), success: "Quiz created successfully"
      else
        render :new, status: :unprocessable_entity, errors: @quiz.errors
      end
    end

    def index
      @quizzes = Quiz.all.order(created_at: :asc)
    end

    def show
      @presenter = QuizPresenter.new(@quiz, current_user)
    end

    private

    def prepare_quiz
      @quiz = Quiz.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:title, :description, :start_at, :expired_at)
    end
  end
end
