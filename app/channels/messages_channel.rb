class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_#{params[:conversation_id]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(payload)
    message = Message.new(
        body: payload['message'],
        user: current_user,
        conversation: Conversation.find(payload['conversation_id'])
    ).save
  end
end
