class CoursesController < ApplicationController
  respond_to :html, :js

  def index
    @user = current_user
    @courses = @user.courses
  end

  def new
    @course = Course.new
    render 'new'
  end

  def create
    @course = Course.create(course_params)
    CourseMembership.create(user: current_user, course: @course)
    @user = current_user
    @courses = current_user.courses

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
    params.require(:course).permit(:organization, :title, :description, :start_date, :end_date)
  end
end
