require 'json'

class AuthorizationsController < ApplicationController

  def new
    @providers = Provider.all
  end

  def create
    @auth_hash = request.env['omniauth.auth']
    user = current_user
    if current_user
      # Means our user is signed in. Add the authorization to the user
      current_user.add_provider(@auth_hash)
      url_stub = "/user/exercises"
      req = user.oauth_request(@auth_hash, url_stub)

      parsed_response = JSON::parse(req.body)
      parsed_response.each do |data|
        data.except!("exercise_model")

        unless data["maximum_exercise_progress_"] == "unstarted"
          course = Course.find_or_create_by(name: data["exercise"])
          coursemembership = CourseMembership.where(user_id: current_user.id).find_or_create_by(course: course)
          if coursemembership.maximum_exercise_progress != data["maximum_exercise_progress_"]
            coursemembership.update(maximum_exercise_progress: data["maximum_exercise_progress_"], last_done: data["last_done"], struggling: data["exercise_states"]["struggling"] )
          end
        end
      end

      render :data_landing, locals: {provider: Provider.find_by(name: @auth_hash[:provider]), data: parsed_response, auth_hash: @auth_hash}

    else
      raise
      redirect_to "/"
    end
  end

  def show
    if current_user
      req = user.oauth_request(@auth_hash)
raise
      render :data_retrieval, locals: {provider: Provider.find_by(name: @auth_hash[:provider]), req: req}
      # render :text => "#{current_user.first_name} can now login using #{auth_hash["provider"].capitalize} too!"
    else
      redirect "/"
    end
  end


end
