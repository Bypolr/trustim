class Message < ApplicationRecord
	belongs_to :conversation
	belongs_to :user

  validates :body, presence: true
  scope :for_display, -> { order(:created_at).last(50) }

  after_create_commit { MessageBroadcastJob.perform_now self }

  def friendly_create_at
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

end
