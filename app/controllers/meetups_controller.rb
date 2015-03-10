class MeetupsController < ApplicationController
  def index
    #upcoming and suggested
    @upcoming = upcoming_meetups
    suggested_meetups
  end

  def show
    # @users = User.all find users in the particular meetup
    @meetup = Meetup.find(params[:id])
    @users = User.all
  end

  def upcoming_meetups
   @meetups =[]
   MeetupMembership.where(user: current_user).each do |membership|
      @meetups << Meetup.find(membership.meetup_id)
   end
    @meetups
  end

  def suggested_meetups
    if current_user
      test = SearchSanitizer.new(current_user.questions.pluck(:title).join(" "))
    end
  end
end
