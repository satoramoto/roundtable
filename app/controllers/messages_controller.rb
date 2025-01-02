# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.create!(message_params.merge(role: "user"))

    # When a message is created from the UI, we respond with a stream if the client supports turbo.
    # The SPA listens on websockets for new messages and appends them to the conversation.
    # The response here is essentially a fallback in case the client does not support websockets.
    # If the client does not support turbo, we redirect to the conversation page.
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to conversation_path(@message.conversation) }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
