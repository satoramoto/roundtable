# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    message = Message.create!(message_params.merge(role: "user"))

    respond_to do |format|
      format.html { redirect_to conversation_path(message.conversation) }
      format.turbo_stream
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
