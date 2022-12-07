class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[show update destroy]
  before_action :create_comment_service, only: %i[create update destroy liked]

  def index
    @comments = Comment.all
  end

  def show
  end

  def create
    # CRIAR SERVICES PARA VER SE O COMENTÁRIO É VALIDO, o mesmo pro POST
    if @comment_service.errors.blank?
      @comment = @comment_service.handle_create_or_update_comment
      render_success('home/index', :created, @comment) if @comment.present?
    else
      render_error(@comment_service.errors.uniq, :unprocessable_entity)
    end
  end

  def update
    if @comment_service.errors.blank?
      @comment = @comment_service.handle_create_or_update_comment(@comment, comment_params)
      render_success('home/index', :ok, @comment) if @comment.present?
    else
      render_error(@comment_service.errors.uniq, :unprocessable_entity)
    end
  end

  def destroy
    if @comment
      @comment = @comment_service.handle_destroy_comment(@comment)
      render_success('home/index', :no_content, @comment) if @comment.present?
    else
      render_error({ error: 'One error has been ocurred' }, :unprocessable_entity)
    end
  end

  def liked
    @comment = @comment_service.handle_like(params[:comment_id], @comment)
    render_success('home/index', :no_content, @comment) if @comment.present?
  end

  private

  def render_success(url, status, data)
    render url, status: status, location: data
  end

  def render_error(error, status)
    render json: error, status: status
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:description, :main_comment_id)
  end

  def create_comment_service
    @comment_service = CommentService.new(
      comment_params[:description],
      comment_params[:main_comment_id],
      params[:post_id]
    )
  end
end
