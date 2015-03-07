class AuthorizationsController < ApplicationController

  def new
    @provider = "khan_academy"
  end

  def create
    auth_hash = request.env['omniauth.auth']
    p auth_hash.credentials # Contains the token and secret
    user = current_user
    if current_user
      # Means our user is signed in. Add the authorization to the user
      req = user.oauth_request(auth_hash)
      render :data_retrieval, locals: {provider: Provider.find_by(name: auth_hash[:provider]), req: req}
      # render :text => "#{current_user.first_name} can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth_hash)

      # Create the session
      current_user = auth.user.id

      render :text => "Welcome #{auth.user.first_name auth.user.last_name}!"
    end
  end

end
