module MessagesHelper
  def sender_username_for(message)
    message.conversation.sender.username
  end

  def recipient_username_for(message)
    message.conversation.recipient.username
  end
end
