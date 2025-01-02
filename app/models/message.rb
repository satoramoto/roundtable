class Message < ApplicationRecord
  belongs_to :conversation

  validates :content, presence: true
  validates :role, presence: true

  # Implicitly order by created_at descending to show the newest messages first
  default_scope { order(created_at: :desc) }

  # Whenever a message is created, we want to broadcast a message to the conversation channel
  after_create_commit { broadcast_prepend_to conversation }

  # Whenever a message is created by a user, we need to trigger a response from the bot
  after_create_commit :trigger_bot_response, if: -> { role == "user" }

  # This method is called whenever a message is created by a user
  def trigger_bot_response
    # We want to create a new message from the bot in the same conversation
    Message.create!(content: "I'm a bot! 🤖", role: "assistant", conversation: conversation)
  end
end
