class MessagesController < ApplicationController
  include MessagesHelper

  before_action :check_logged_in
  before_action :get_messages

  def index
  end

  def create
    message = current_user.messages.build(message_params)
    message.conversation = Conversation.all.first # test
    if message.save
      ActionCable.server.broadcast 'message_channel', rendered_message: rendered_message(message)
      redirect_to show_conversation_path(
        sender_username_for(message), recipient_username_for(message))
    else
      flash.now[:error] = "Message sending failed."
      render :index
    end
  end

  private

  def get_messages
    @messages = Message.for_display
    @message = current_user.messages.build
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def rendered_message(message)
    <<-EOF
    <div class="message"><div class="message-user">#{message.user.username}:</div>
    <div class="message-content">#{message.body}</div></div>
    EOF
  end
end
