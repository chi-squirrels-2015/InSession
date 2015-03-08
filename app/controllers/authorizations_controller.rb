require 'json'

class AuthorizationsController < ApplicationController

  def new
    @providers = Provider.all
  end

  def create
    @auth_hash = request.env['omniauth.auth']
    p @auth_hash.credentials # Contains the token and secret
    user = current_user
    if current_user
      # Means our user is signed in. Add the authorization to the user
      current_user.add_provider(@auth_hash)
      url_stub = "/user"
      req = user.oauth_request(@auth_hash, url_stub)

      parsed_response = JSON::parse(req.body)

      render :data_landing, locals: {provider: Provider.find_by(name: @auth_hash[:provider]), data: parsed_response, auth_hash: @auth_hash}

    else
      redirect_to :back
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
