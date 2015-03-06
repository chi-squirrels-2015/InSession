class AuthorizationsController < ApplicationController
  # def create
  # auth_hash = request.env['omniauth.auth']
  # @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

  #   if @authorization
  #     render :text => "Welcome back #{@authorization.user.name}! You have already linked your account"
  #   else
  #     user = current_user # modified tuts tutorial code with current_user
  #     user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  #     user.save

  #     render :text => "Hi #{user.name}! You've signed up."
  #   end
  # end
  def new
    @provider = "khan_academy"
  end

  def create

    auth_hash = request.env['omniauth.auth']

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
