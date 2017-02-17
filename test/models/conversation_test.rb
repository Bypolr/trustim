require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:michael)
    @user2 = users(:archer)
  end

  test "sender should not be same as recipient" do
    conversation = Conversation.new(sender: @user1, recipient: @user1)
    conversation.save
    assert conversation.errors.present?
    assert conversation.errors.full_messages[0].eql? "Recipient can't be same as sender"
  end

  test "sender-recipient pair is unique globally" do
    conversation = Conversation.new(sender: @user1, recipient: @user2)
    conversation.save

    conversation2 = Conversation.new(sender: @user2, recipient: @user1)
    conversation2.save

    assert conversation2.errors.present?
    assert conversation2.errors.full_messages[0].eql? "Conversation already existed"
  end

end
