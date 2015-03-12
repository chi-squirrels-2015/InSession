class MeetupsController < ApplicationController
  def index
    #upcoming and suggested
    @upcoming = upcoming_meetups
    if current_user
      array_of_titles = []
      user_exercices = current_user.exercises
      user_exercices.each{|exercise| array_of_titles << exercise.title}
      clean_query = SearchSanitizer.new(array_of_titles.flatten.join(" "))

      # OLDER IF ISSUE ASK JD ####################################################################
      # @courses_based_meetups = Meetup.search(query: {multi_match: {_all: {query: clean_query.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})

      # @courses_based_meetups = Meetup.search(clean_query.sanitized)
      #############################################################################@##############

      # puts clean_query.sanitized
      @courses_based_meetups = Meetup.search(query: {multi_match: {_all: {query: clean_query.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})

     test = SearchSanitizer.new(current_user.questions.pluck(:title).join(" "))
      puts "#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts test.sanitized
      puts "#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      @meetups = Meetup.search(test.sanitized)
      @meetups = Meetup.search(query: {match: {_all: {query: test.sanitized, fuzziness: 1}}})
    end
  end

  def new
    @meetup = Meetup.new
    @venues = Venue.all
  end

  def create
    @course = Course.find_by_title(params[:meetup][:course])
    @venue = Venue.find_by_name(params[:meetup][:venue])
    @meetup = Meetup.create(
      course: @course,
      venue: @venue,
      organizer: current_user,
      title: params[:meetup][:title],
      description: params[:meetup][:description],
      scheduled_date: params[:meetup][:scheduled_date],
      begin_time: params[:meetup][:begin_time],
      end_time: params[:meetup][:end_time]
    )
    redirect_to meetup_path(@meetup)

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

  # def suggested_meetups
  #   if current_user
  #     test = SearchSanitizer.new(current_user.questions.pluck(:title).join(" "))
  #     @meetups = Meetup.search(query: {multi_match: {_all: {query: test.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})
  #     binding.pry
  #     p @meetups
  #     p @meetups
  #   end
  # end

  def destroy
    meetup = Meetup.find(params[:id])
    if meetup
      meetup.destroy
      redirect_to meetups_path
    else
      redirect_to meetups_path
    end
  end

  def meetup_params
    #get attributed from db
    params.require(:meetup).permit(:title, :venue)
  end
end
