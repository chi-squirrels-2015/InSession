class CoursesController < ApplicationController
  respond_to :html, :js

  def index
    @user = User.find(current_user)
    @courses = @user.courses
  end

  def show
    @course = Course.find(params[:id])
    render 'show' 
  end
end


