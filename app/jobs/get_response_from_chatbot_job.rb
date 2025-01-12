require "redcarpet"

class GetResponseFromChatbotJob < ApplicationJob
  queue_as :default

  SYSTEM_PROMPT = File.read(Rails.root.join("prompts", "roundtable_v2.md"))

  def perform(conversation)
    # Create an empty message right away to indicate that the bot is typing
    # The message will be updated with the actual content once the bot responds
    # The Message model has callbacks which stream the updates to the UI using Turbo
    message = Message.create!(content: "**The RoundTable** is Spinning...", role: "assistant", conversation: conversation)

    # The LLM needs the context of the conversation to generate a response
    # In our case, the context is just every message sent in the conversation so far
    messages = conversation.messages.select(:role, :content).order(created_at: :asc)
    messages = messages.map { |m| { role: m.role, content: m.content } }

    # Additionally we need a system message, which is the "directive" for the conversation
    messages = [ { role: "system", content: SYSTEM_PROMPT } ] + messages

    content = ""
    OpenAiClient.new.chat_completions(messages: messages) do |chunk|
      content << chunk["choices"][0]["delta"]["content"]
      next if content.blank? || chunk["choices"][0]["finish_reason"]
      message.update!(content: content, role: "assistant", conversation: conversation)
    end

  rescue StandardError => e
    return unless message
    message.update(content: "**Albert Einstein:** I'm sorry, I'm having trouble connecting to the AI service.",
                    role: "assistant",
                    conversation: conversation)
  end
end
