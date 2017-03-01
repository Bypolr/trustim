class ConversationsController < ApplicationController

  before_action :check_logged_in, only: [:show]
  before_action :check_user_pair, only: [:show]

  def show
    @conversation = Conversation.between(@sender.id, @recipient.id).first

    unless @conversation
      @conversation = Conversation.create!(sender_id: @sender.id, recipient_id: @recipient.id)
    else

      @unread_messages = @conversation.messages.unread_by(current_user).order(:created_at) || []
      @has_unread_messages = @unread_messages.count > 0

      if @has_unread_messages
        Message.mark_as_read! @unread_messages.to_a, for: current_user
      end
      @read_messages = (@conversation.messages.order(:created_at) - @unread_messages) || []

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
