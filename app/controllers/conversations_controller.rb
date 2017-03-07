class ConversationsController < ApplicationController

  before_action :check_logged_in, only: [:show]
  before_action :check_user_pair, only: [:show]

  def show
    @conversation = Conversation.between(@sender.id, @recipient.id).first

    # Initialize messages arrays used in template.
    @unread_messages = []
    @read_messages = []

    # Create the conversation between users if it does not exist.
    unless @conversation
      @conversation = Conversation.create!(sender_id: @sender.id, recipient_id: @recipient.id)
    else
      # Get read/unread messages from the conversation for current user.
      if @conversation.messages.any?
        @unread_messages = @conversation.unread_messages_for(current_user)
        @read_messages = @conversation.read_messages_for(current_user)

        # Mark @unread_messages as read.
        if @unread_messages.any?
          Message.mark_as_read! @unread_messages.to_a, for: current_user
        end
      end
    end

    render :show
  end

  private

  # Before filters

  # Confirms a logged-in user.
  def check_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Check if users pare exists.
  def check_user_pair
    @sender = User.find_by(username: params[:sender_username])
    @recipient = User.find_by(username: params[:recipient_username])
    unless @sender && @recipient
      flash[:danger] = "Some user does not exist."
      redirect_to users_url
    end
  end
end
