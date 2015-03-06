class ResponsesController < ApplicationController

  def new
    @question = Question.find_by_id(params[:question_id])
    @response = Response.new
  end

  def create
    @question = Question.find(params[:question_id])
    response = Response.new(response_params)
    if response.save
      redirect_to index                                                                                             
    else
      render 'new' unless @response.save
    end
  end

  private

  def response_params
    params.require(:response).permit(:content).merge({user: current_user, question: @question})
  end
end
