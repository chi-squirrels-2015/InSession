class QuestionsController < ApplicationController
  respond_to :html, :js

  def index
    @questions = Question.order(created_at: :desc).limit(5)
  end

  def new
   #will render new form
   @question = Question.new
 end

 def create
  @question = Question.new(question_params)

  if submit_new_question?
    @question.user = current_user
    @questions = Question.order(created_at: :desc).limit(10)

    render 'new' unless @question.save

  elsif preview?
    @content = markdown(params[:question][:content]).gsub("\n","<p></p>")
    render :preview
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

def edit
  @question = Question.find(params[:id])
  render 'edit'  
end

def update
  @question = Question.find(params[:id])
  @question.update(question_params)
end

private
def question_params
    #get attributed from db
    params.require(:question).permit(:content, :title)
  end

  def submit_new_question?
    params[:commit] == "Submit New Question"
  end

  def preview?
    params[:commit] == "Preview"
  end
end
