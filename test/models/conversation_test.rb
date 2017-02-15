require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  def setup
    @user = User.all.first
    @conversation = Conversation.new(sender_id: @user.id, recipient_id: @user.id)
  end

  test "sender_id should not be same as recipient_id" do
    @conversation.save
    assert @conversation.errors.present?
    assert @conversation.errors.full_messages[0].eql? "Recipient can't be same as sender"
    print
  end
end
