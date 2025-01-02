class GetResponseFromChatbotJob < ApplicationJob
  queue_as :default

  def perform(conversation)
    # The LLM needs the context of the conversation to generate a response
    messages = conversation.messages.select(:role, :content).order(created_at: :asc)
    messages = messages.map { |message| { role: message.role, content: message.content } }

    # Additionally we need a system message, which is the "directive" for the conversation
    messages = [ { role: "system", content: "You are a helpful assistant." } ] + messages
    response = OpenAiClient.new.chat_completions(messages: messages, stream: false)

    # Parse the response and create a new message from the bot
    Message.create!(content: response["choices"][0]["message"]["content"], role: "assistant", conversation: conversation)

  rescue
     Message.create!(content: "I'm sorry, I'm having trouble connecting to the AI service.", role: "assistant", conversation: conversation)
  end
end
