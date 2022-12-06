class UserChatService
  attr_accessor :receiver_id

  def initialize(receiver_id)
    @receiver_id = receiver_id
  end

  def errors
    errors ||= []

    [
      { condition: @receiver_id.blank?, message: "Receiver references can't be blank." },
      { condition: receiver_unexistent, message: 'Unexistent chat.' }
    ].each do |error|
      errors << error[:message] if error[:condition]
    end

    errors
  end

  def receiver_unexistent
    receiver ||= true
    receiver = User.find(@receiver_id)
    !receiver
  end

  def handle_create_user_chat
    unless chat_already_exist
      chat = Chat.create!
      @chat_id = chat.id

      user_chats_to_create = [
        { chat_id: @chat_id, user_id: current_user.id },
        { chat_id: @chat_id, user_id: @receiver_id }
      ]

      UserChat.create(user_chats_to_create)
    end
  end

  private

  def chat_already_exist
    !!UserChat.find_by(user_id: current_user.id)
  end
end
