class StaticController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


	def index
    @users = User.all

		if current_user
            test = SearchSanitizer.new(current_user.questions.pluck(:title).join(" "))
			@meetups = Meetup.search(query: {multi_match: {_all: {query: test.sanitized, fuzziness: 1, fields: ['title^10', 'body']}}})
		end
	end
end
















