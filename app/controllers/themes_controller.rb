class ThemesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theme, only: %i[show destroy]

  def index
    @themes = Theme.all
  end

  def show
  end

  def destroy
    theme_service = ThemeService.new(@theme, @theme_id)
    theme_service.handle_destroy_theme
    render 'home/index', status: :no_content, location: nil
  end

  private

  def set_theme
    @theme = Theme.find(params[:id])
  end
end
