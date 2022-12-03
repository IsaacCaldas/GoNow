class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[ show update destroy ]
  
  def index 
    @comments = Comment.all 
  end

  def show 
  end

  def create 
    # CRIAR SERVICES PARA VER SE O COMENTÁRIO É VALIDO, o mesmo pro POST
    @comment = Comment.new(comment_params)
    if @comment.save
      # render "home/index", status: :created, location: @comment
    else
      render json: { error: 'One error has been ocurred' }, status: :unprocessable_entity
    end
  end

  def update 
    if @comment.update(comment_params)
      # render "home/index", status: :ok, location: @comment
    else
      render json: { error: 'One error has been ocurred' }, status: :unprocessable_entity
    end
  end

  def destroy 
    if @comment
      @comment.update(description: 'O comentário pode ter sido apagado.')
      # render "home/index", status: :no_content, location: @comment
    else
      render json: { error: 'One error has been ocurred' }, status: :unprocessable_entity
    end
  end

  private 

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:description, :likes, :main_comment_id, :post_id, :user_id)
  end
end  
