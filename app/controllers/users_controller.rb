class UsersController < ApplicationController
  def show
    @user = current_user.id
  end
end
