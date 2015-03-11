class CoursesController < ApplicationController
  respond_to :html, :js

  def index
    @user = User.find(current_user)
    @courses = @user.courses
  end

  def new
    @course = Course.new
    render 'new'
  end

  def create
    @course = Course.create(course_params)
    @course.user = current_user
    render 'index'
  end


  def show
    @course = Course.find(params[:id])
    render 'show' 
  end

  def edit
    @course = Course.find(params[:id])
    render 'edit'  
  end

private
def course_params
    #get attributed from db
    params.require(:course).permit(:organization, :title)
  end
end
