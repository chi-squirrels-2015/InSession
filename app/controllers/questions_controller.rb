class QuestionsController < ApplicationController
  respond_to :html, :js

  def index
    @questions = Question.all
  end

  def new
   #will render new form
    @question = Question.new
  end

  def create
  # @question = Question.new(question_params) 
    if submit_new_question?
      @question.user = current_user
     render 'new' unless @question.save
   end
  end

  def show
    @question = Question.find(params[:id])
    if @question.save
      render 'show'
    else
      render 'new'
    end
  end

  private
  def question_params
    #get attributed from db
    params.require(:question).permit(:content, :title)
  end

  def submit_new_question?
    params[:commit] == "Submit New Question"
  end
end
