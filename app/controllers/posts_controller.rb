class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show update destroy liked ]
  before_action :create_post_service, only: %i[ create update liked ]

  def index 
    @posts = Post.all 
  end

  def show 
  end

  def create 
    unless @post_service.errors.present?
      @post = @post_service.create_post(post_params)
      render "home/index", status: :created, location: @post
    else
      render json: @post_service.errors.uniq, status: :unprocessable_entity
    end
  end

  def update 
    unless @post_service.errors.present?
      @post = @post_service.update_post(@post, post_params)
      render "home/index", status: :ok, location: @post
    else
      render json: @post_service.errors.uniq, status: :unprocessable_entity
    end
  end

  def destroy 
    if @post.destroy
      render "home/index", status: :no_content, location: @post
    else
      render json: { error: 'One error has been ocurred' }, status: :unprocessable_entity
    end
  end

  def liked
    @post = @post_service.handle_like(params[:post_id], current_user, @post)
    render "home/index", status: :no_content, location: @post if @post.present?
  end

  private 

  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title :description, :likes, :image_url, :theme_id, :user_id, :)
  end

  def create_post_service
    @post_service = PostService.new(
      post_params[:title],
      post_params[:theme_id],
      post_params[:user_id],
    )
  end
end
