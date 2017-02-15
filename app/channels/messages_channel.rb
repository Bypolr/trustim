class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.new(body: data['message'],
                          user_id: current_user.id,
                          conversation_id: session[:conversation_id])
    if message.save!
      ActionCable.server.broadcast 'message_channel', message: data['message']
    end
  end
end
