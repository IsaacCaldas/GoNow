class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy liked]
  before_action :create_post_service, only: %i[create update liked]

  def index
    @posts = Post.all
  end

  def show
  end

  def create
    if @post_service.errors.blank?
      @post = @post_service.handle_create_or_update_post
      render_success('home/index', :created, @post) if @post.present?
    else
      render_error(@post_service.errors.uniq, :unprocessable_entity)
    end
  end

  def update
    if @post_service.errors.blank?
      @post = @post_service.handle_create_or_update_post(@post, post_params)
      render_success('home/index', :ok, @post) if @post.present?
    else
      render_error(@post_service.errors.uniq, :unprocessable_entity)
    end
  end

  def destroy
    # se apagar o post tem que apagar os comentários
    if @post.destroy
      render_success('home/index', :no_content, nil)
    else
      render_error({ error: 'One error has been ocurred' }, :unprocessable_entity)
    end
  end

  def liked
    @post = @post_service.handle_like(params[:post_id], @post)
    render_success('home/index', :no_content, @post) if @post.present?
  end

  private

  def render_success(url, status, data)
    render url, status: status, location: data
  end

  def render_error(error, status)
    render json: error, status: status
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image_url, :theme_id)
  end

  def create_post_service
    @post_service = PostService.new(
      post_params[:title],
      post_params[:description],
      post_params[:image_url],
      post_params[:theme_id]
    )
  end
end
