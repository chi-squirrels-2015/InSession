class UsersController < ApplicationController
  def show
    @user = current_user.id

    @meetups_near_me = Array.new
    @courses = Array.new
    @meetups = Array.new

    @venues_near_me = Venue.near([current_user.latitude, current_user.longitude], current_user.max_distance)

    @venues_near_me.each do |venue|
      @meetups_near_me << venue.meetups if venue.meetups.length > 0
    end

    @meetups_near_me.flatten!

    @meetups_near_me.each do |meetup|
      @courses << [meetup.course.title, meetup.id]
    end
    render :show
  end
end
