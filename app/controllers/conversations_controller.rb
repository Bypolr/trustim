class ConversationsController < ApplicationController

  before_action :check_logged_in, only: [:show]
  before_action :check_user_pair, only: [:show]

  def show
    @conversation = Conversation.between(@sender.id, @recipient.id).first
    unless @conversation
      @conversation = Conversation.create!(sender_id: @sender.id, recipient_id: @recipient.id)
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
