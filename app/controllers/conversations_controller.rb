class ConversationsController < ApplicationController

  before_action :check_logged_in, only: [:show]

  def show
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    session[:conversation_id] = @conversation.id

    render :show
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  # Before filters

  # Confirms a logged-in user.
  def check_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
