class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_#{params[:conversation_id]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(payload)
    Message.new(
        body: payload['message'],
        user: current_user,
        conversation: Conversation.find(payload['conversation_id'])
    ).save
  end

  def got(payload)
    message = Message.find_by(id: payload['message_id'])
    user = User.find_by(id: payload['user_id'])
    message.mark_as_read! for: user
  end
end
