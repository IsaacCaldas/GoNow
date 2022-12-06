class UserChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_chat, only: %i[ show ]
  before_action :create_user_chat_service, only: %i[ create ]

  def index 
    @user_chats = UserChat.where(user_id: current_user.id)
  end

  def show 
  end

  def create 
    unless @user_chat_service.errors.present?
      @user_chat = @user_chat_service.handle_create_user_chat
      render_success("home/index", :created, @user_chat) if @user_chat.present?
    else
      render_error(@user_chat_service.errors.uniq, :unprocessable_entity)
    end
  end

  private 

  def render_success(url, status, data)
    render url, status: status, location: data
  end

  def render_error(error, status)
    render json: error, status: status
  end

  def set_user_chat 
    @user_chat = UserChat.find(params[:id])
  end

  def user_chat_params
    params.require(:user_chat).permit(:receiver_id)
  end

  def create_user_chat_service
    @user_chat_service = UserChatService.new(user_chat_params[:receiver_id])
  end
end
