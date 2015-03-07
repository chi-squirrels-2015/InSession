class ResponsesController < ApplicationController
  respond_to :html, :js
  def index
    @responses = Response.order(created_at: :desc).limit(5)
  end

  def new
    @question = Question.find_by_id(params[:question_id])
    @response = Response.new(question: @question)
  end

  def create
    @question = Question.find(params[:question_id])
    @response = Response.new(response_params)
    if @response.save
      redirect_to index                                                                                             
    else
      render 'new' unless @response.save
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    @response = Response.find(question_id: @question.id)
    render 'edit'  
  end

  def update
    @question = Question.find(params[:question_id])
    @response = Response.find(question_id: @question.id)
    @response.update 
  end

  private

  def response_params
    params.require(:response).permit(:content).merge({user: current_user, question: @question})
  end
end
