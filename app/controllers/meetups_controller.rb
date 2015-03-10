class MeetupsController < ApplicationController
  def index
    #upcoming and suggested
    @upcoming = upcoming_meetups
    if current_user
      array_of_titles = []
      user_exercices = UserExercise.where(user_id:current_user.id)
      user_exercices.each{|exercise| array_of_titles << exercise.exercise.title}
      clean_query = SearchSanitizer.new(array_of_titles.flatten.join(" "))
      @courses_based_meetups = Meetup.search(query: {multi_match: {_all: {query: clean_query.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})
    end
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
      @meetups = Meetup.search(query: {multi_match: {_all: {query: test.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})
    end
  end



end
