class MeetupsController < ApplicationController
  def index
    #upcoming and suggested
    @upcoming = upcoming_meetups
    if current_user
      array_of_titles = []
      user_exercices = current_user.exercises
      user_exercices.each{|exercise| array_of_titles << exercise.title}
      clean_query = SearchSanitizer.new(array_of_titles.flatten.join(" "))
      puts clean_query
      puts clean_query
      puts clean_query.sanitized
      puts clean_query.sanitized
      # @courses_based_meetups = Meetup.search(query: {multi_match: {_all: {query: clean_query.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})
      @courses_based_meetups = Meetup.search(clean_query.sanitized)
    end
  end

  def show
    # @users = User.all find users in the particular meetup
    @meetup = Meetup.find(params[:id])
    @users = MeetupMembership.where(meetup: @meetup).map{ |e| User.find(e.user_id)}
    @organizer = User.find(@meetup.organizer_id)
    @venue = Venue.find(@meetup.venue_id)
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
      @meetups = Meetup.search(query: {multi_match: {_all: {query: test.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})
    end
  end



end
