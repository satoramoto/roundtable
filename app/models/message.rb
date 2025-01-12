class Message < ApplicationRecord
  belongs_to :conversation

  validates :content, presence: true
  validates :role, presence: true

  # Create a scope which shows the newest messages first
  # This is useful for displaying messages in the correct order in the UI
  # This can be used anywhere by calling Message.newest_first
  scope :newest_first, -> { order(created_at: :desc) }

  # Whenever a message is created, we want to notify the UI so it can update in real-time
  # broadcast_prepend_later_to is a convenience method provided by Turbo which streams a partial view to UI
  # The method is called after_create_commit, which is a Rails callback that is triggered after a new record is created
  # The method runs in the background and does not block the request thread
  # Since we are in the message model, the method knows to use the partial from views/messages/_message.html.erb
  # The target div is assumed to be named after the model, so in this case, it would be "messages"
  # The corresponding stream and div are defined in app/views/conversations/show.html.erb
  after_create_commit { broadcast_prepend_later_to conversation }

  # Whenever a message is updated, we want to notify the UI so it can update in real-time
  # This is the mechanism by which we achieve the effect of the bot typing
  # Every time we get a new chunk of text from the bot, we update the message model which triggers this callback
  # broadcast_replace_later_to method replaces the content of the target div with the message partial
  # The message id comes from the message partial in views/messages/_message.html.erb
  # Note that in this case and the above case, we are rending the same parti
  after_update_commit { broadcast_replace_later_to conversation, target: "message-#{id}" }

  # Whenever a message is created by a user, we need to trigger a response from the bot
  # This is done in a background job to keep the response time low
  # The request thread should not be blocked while waiting for the bot to respond
  # The job is enqueued with the perform_later method, which tells ActiveJob to run the job asynchronously
  after_create_commit { GetResponseFromChatbotJob.perform_later(conversation) if role == "user" }
end
