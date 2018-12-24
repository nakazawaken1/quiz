class QuestionsController < ApplicationController
  def index
    @question = Question.find_by(id:1)
  end
  def answer
    @question = Question.find_by(id:1)
    @correct = @question.answer == params[:answer]
    @result = @correct ? "正解" : "残念"
    @icon = @correct ? "sentiment_very_satisfied" : "sentiment_dissatisfied"
    render(partial:'answer')
  end
end
