class QuestionsController < ApplicationController
  skip_before_action :must_logged_in
  before_action :load_categories, except: [:home, :answer, :index, :destroy]
  def home
    unless cookies.permanent[:question_id]
      questions = Question.order("RAND()").limit(1);
      cookies.permanent[:question_id] = questions.empty? ? null : questions[0].id
    end
    @question = Question.find_by(id: cookies.permanent[:question_id])
  end
  def answer
    logger.debug cookies.permanent[:question_id]
    question = Question.find_by(id: cookies.permanent[:question_id])
    correct = question.answer == params[:answer]
    result = t(correct ? :correct : :incorrect)
    icon = correct ? :sentiment_very_satisfied : :sentiment_dissatisfied
    if correct
      cookies.delete :question_id
    end
    render partial: 'answer', locals: { question: question, correct: correct, result: result, icon: icon }
  end
  def index
    @questions = Question.all
  end
  def edit
    @question = Question.find_by(id: params[:id])
  end
  def update
    @question = Question.find_by(id: params[:id])
    @question.question = params[:question]
    @question.answer = params[:answer]
    @question.hint = params[:hint]
    @question.comment = params[:comment]
    if @question.save
      flash[:notice] = t :updated
      redirect_to action: :index
    else
      render action: :edit
    end
  end
  def new
    @question = Question.new
  end
  def create
    @question = Question.new(params.permit(:question, :answer, :hint, :comment))
    if @question.save
      flash[:notice] = t :created
      redirect_to action: :index
    else
      render action: :new
    end
  end
  def destroy
    Question.find_by(id: params[:id]).destroy
    flash[:notice] = t :destroyed
    redirect_to action: :index
  end
  def load_categories
    @categories = Category.all
  end
end
