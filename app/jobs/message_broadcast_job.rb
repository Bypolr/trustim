class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "messages_#{message.conversation.id}",
      message: { user_id: message.user_id, username: message.user.username, body: message.body,
                 created_at: message.friendly_create_at }
  end
  #
  # private
  #   def render_message(message)
  #     ApplicationController.renderer.render(
  #       partial: 'messages/message',
  #       locals: { message: message, current_user: message.user}
  #     )
  #   end
end
