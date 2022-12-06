class ThemeService 
  attr_accessor :theme 

  def initialize(theme, theme_id)
    @theme = theme
    @theme_id = theme_id
  end
 
  def handle_destroy_theme
    handle_dependents if @theme.destroy
  end

  private

  def handle_dependents
    posts = Post.where(theme_id: @theme_id)
    posts.update(theme_id: Theme.find_by(name: 'Default').id)
  end

end