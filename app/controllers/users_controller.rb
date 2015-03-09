class UsersController < ApplicationController
  def show
    @user = current_user.id
  end

  def self.name
  	user.first_name + user.last_name
  end	
end
