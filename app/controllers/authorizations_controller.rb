class AuthorizationsController < ApplicationController

  def new
    @provider = "khan_academy"
  end

  def create
    auth_hash = request.env['omniauth.auth']
    p auth_hash.credentials # Contains the token and secret
    if current_user
      # Means our user is signed in. Add the authorization to the user
      current_user.add_provider(auth_hash)

      render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth_hash)

      # Create the session
      current_user = auth.user.id

      render :text => "Welcome #{auth.user.first_name auth.user.last_name}!"
    end
  end
end
