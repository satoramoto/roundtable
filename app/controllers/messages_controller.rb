# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.create!(message_params.merge(role: "user"))

    # When a message is created from the UI, we respond with a stream if the client supports turbo.
    # The conversation page listens for new messages using websockets and appends them to the conversation.
    # We return the message as JSON just like we would in a normal API response.
    # TODO I'm not sure if this is best practice with turbo streams but hey, I'm learning too!
    # If the client doesn't support turbo, we redirect to the conversation page aka hard refresh.
    respond_to do |format|
      format.turbo_stream { render json: @message }
      format.html { redirect_to conversation_path(@message.conversation) }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
