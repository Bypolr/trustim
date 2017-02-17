class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id
  validate :sender_cannot_be_recipient, :unique_sender_recipient_pair

  scope :between, -> (sender_id, recipient_id) do
    where("
      (conversations.sender_id = ? AND conversations.recipient_id = ?) OR
      (conversations.sender_id = ? AND conversations.recipient_id = ?)
      ", sender_id, recipient_id, recipient_id, sender_id)
  end

  private

    def sender_cannot_be_recipient
      if sender_id && recipient_id && sender_id.eql?(recipient_id)
        errors.add(:recipient_id, "can't be same as sender")
      end
    end

    def unique_sender_recipient_pair
      if Conversation.between(sender_id, recipient_id).count >= 1
        errors.add(:conversation, "already existed")
      end
    end
end
