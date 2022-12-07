class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :handle_username

  def index
  end

  private 

  def handle_username
    return if !current_user || current_user.username.split('')[0] == '@'
    User.handle_update_username(current_user)
  end
end
