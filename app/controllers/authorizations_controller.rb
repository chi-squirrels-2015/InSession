require 'json'

class AuthorizationsController < ApplicationController

  def new
    @providers = Provider.all
  end

  def create

    auth_hash = authenticate

    user = current_user
    if current_user
      # Means our user is signed in. Add the authorization to the user
      current_user.add_provider(auth_hash)
      url_stub = "/user/exercises"
      req = user.oauth_request(auth_hash, url_stub)

      parsed_response = JSON::parse(req.body)

      parsed_response.each do |data|
        unless data["maximum_exercise_progress_"] == "unstarted"
          course = Course.find_or_create_by(name: data["exercise"])
          coursemembership = CourseMembership.where(user_id: current_user.id).find_or_create_by(course: course)
          if coursemembership.maximum_exercise_progress != data["maximum_exercise_progress_"]
            coursemembership.update(maximum_exercise_progress: data["maximum_exercise_progress_"], last_done: data["last_done"], struggling: data["exercise_states"]["struggling"] )
          end
        end
      end

      enrolled_courses = CourseMembership.where(user_id: current_user.id)
      render :data_landing, locals: {provider: Provider.find_by(name: auth_hash[:provider]), enrolled_courses: enrolled_courses, auth_hash: auth_hash}

    else
      raise
      redirect_to "/"
    end
  end

  def authenticate
    auth_hash = request.env['omniauth.auth']
    provider = Provider.find_by(name: auth_hash.provider)
    auth = current_user.authorizations.find_or_create_by(provider: provider)
    auth.user_secret = auth_hash.credentials.secret
    auth.user_token = auth_hash.credentials.token
    auth.uid = auth_hash.credentials.uid
    auth.save
    auth_hash
  end


end
