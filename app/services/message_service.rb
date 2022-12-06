class MessageService 
  attr_accessor :content, :chat_id

  def initialize(content, chat_id)
    @content = content
    @chat_id = chat_id
  end

  def errors
    errors ||= []
  
    [
      {condition: @content.blank?, message: "Message needs a content."},
      {condition: @chat_id.blank?, message: "Chat references can't be blank."},
      {condition: chat_unexistent, message: "Unexistent chat."}
    ].each do |error|
      errors << error[:message] if error[:condition]
    end

    errors
  end

  def chat_unexistent
    chat = true
    chat = Chat.find(@chat_id)
    !chat
  end

  def handle_create_message
    # TODO: make a validation of params
    Message.create(content: @content, chat_id: @chat_id, user_id: current_user.id)
  end

  def handle_destroy_message(message)
    message.update(content: 'The message has been removed')
  end
end 