class MessagesController < ApplicationController
  include MessagesHelper

  before_action :check_logged_in
  before_action :get_messages

  def index
  end

  private

  def get_messages
    @messages = Message.for_display
    @message = current_user.messages.build
  end

  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id)
  end
end
