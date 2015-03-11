class MeetupMembershipsController < ApplicationController

  def new
    membership = MeetupMembership.create(user: current_user, meetup_id: params[:id])
    redirect_to meetup_path(params[:id])
  end


  def destroy
    membership = MeetupMembership.find(params[:id])
    meetup_id = membership.meetup_id
    if membership
      membership.destroy
      redirect_to meetup_path(meetup_id)
    else
      redirect_to meetups_path
    end
  end
end


