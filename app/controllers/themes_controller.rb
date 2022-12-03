class ThemesController < ApplicationController
  before_action :authenticate_user!

  def index 
    @themes = Theme.all
  end

  def show 
    @theme = Theme.find(params[:id])
  end
end
