require 'test_helper'

class ConversationMessageTest < ActionDispatch::IntegrationTest

  def setup
    @user1 = users(:michael)
    @user2 = users(:archer)
  end

  test "should be able to view messages in conversation" do
    conversation = Conversation.new(sender: @user1, recipient: @user2)
    conversation.save!

    message1 = Message.new(user: @user1, body: 'message one', conversation: conversation)
    message2 = Message.new(user: @user2, body: 'message two', conversation: conversation)
    message1.save!
    message2.save!

    log_in_as(@user1)
    get show_conversation_path(@user1.username, @user2.username)
    assert_template 'conversations/show'
    assert_response :success
    assert_select '.message', 2

    log_in_as(@user2)
    get show_conversation_path(@user2.username, @user1.username)
    assert_select '.message', 2

  end
end
