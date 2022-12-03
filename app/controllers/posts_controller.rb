class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show update destroy ]

  def index 
    @posts = Post.all 
  end

  def show 
  end

  def create 
    @post = Post.new(post_params)
    if @post.save
      render "home/index", status: :created, location: @post
    else
      render json: { error: 'One error has been ocurred' }, status: :unprocessable_entity
    end
  end

  def update 
    if @post.update(post_params)
      render "home/index", status: :ok, location: @post
    else
      render json: { error: 'One error has been ocurred' }, status: :unprocessable_entity
    end
  end

  def destroy 
    if @post.destroy
      render "home/index", status: :no_content, location: @post
    else
      render json: { error: 'One error has been ocurred' }, status: :unprocessable_entity
    end
  end

  private 

  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title :description, :likes, :image_url, :theme_id, :user_id)
  end
end
