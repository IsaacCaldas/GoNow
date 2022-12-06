class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[ destroy ]
  before_action :create_message_service, only: %i[ create destroy ]

  def create 
    if @message_service.errors.blank?
      @message = @message_service.handle_create_message
      render_success("home/index", :created, @message) if @message.present?
    else
      render_error(@message_service.errors.uniq, :unprocessable_entity)
    end
  end

  def destroy
    @message_service.handle_destroy_message(@message)
  end

  private 

  def render_success(url, status, data)
    render url, status: status, location: data
  end

  def render_error(error, status)
    render json: error, status: status
  end

  def set_message 
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def create_message_service
    @message_service = MessageService.new(
      message_params[:content],
      params[:chat_id]
    )
  end
end
