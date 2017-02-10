class MessagesController < ApplicationController

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  # def index
  #   @messages = @conversation.messages
  #   if @messages.length > 10
  #     @over_ten = true
  #     @messages = @messages[-10..-1]
  #   end
  #
  #   if params[:m]
  #     @over_ten = false
  #     @messages = @conversation.messages
  #   end
  #
  #   if @messages.last and @messages.last.user_id != current_user.id
  #     @messages.last.read = true
  #   end
  #
  #   @message = @conversation.messages.new
  #
  # end

  def create
    @message = @conversation.messages.new(message_params)
    if !@message.save!
      flash[:error] = "cannot save message"
    end

    redirect_to show_conversation_path(@conversation.sender_id, @conversation.recipient_id)

  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
