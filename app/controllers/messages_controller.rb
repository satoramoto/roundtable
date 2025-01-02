# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.create!(message_params.merge(role: "user"))

    # TODO I'm not sure if this is best practice with turbo streams but hey, I'm learning too!
    # We are broadcasting all message creates in the model, so we don't have to do it here.
    # This gets us two things for free:
    # 1. The browser will automatically update with this message and the response from the bot.
    # 2. This also keeps two browser windows in sync.
    # Something about this seems wrong though. We respond with no content to browser on success. Seems funny.
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
