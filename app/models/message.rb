class Message < ApplicationRecord
  belongs_to :conversation

  validates :content, presence: true
  validates :role, presence: true

  # Implicitly order by created_at descending to show the newest messages first
  scope :newest_first, -> { order(created_at: :desc) }

  # Whenever a message is created, we want to broadcast a message to the conversation channel
  after_create_commit { broadcast_prepend_later_to conversation }

  # Whenever a message is created by a user, we need to trigger a response from the bot
  # This is done in a background job to keep the response time low
  after_create_commit { GetResponseFromChatbotJob.perform_later(conversation) if role == "user" }
end
