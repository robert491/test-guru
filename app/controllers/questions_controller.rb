class QuestionsController < ApplicationController
  before_action :find_test,     only: %i[index create new]
  before_action :find_question, only: %i[show destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    @questions = @test.questions
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to :test_questions
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @question.update(question_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @question.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_record_not_found
    render plain: 'record not found'
  end
end
