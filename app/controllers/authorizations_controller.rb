require 'json'

class AuthorizationsController < ApplicationController

  def new
    @providers = Provider.all
  end

  def create
  end

  def authenticate
  end

end
