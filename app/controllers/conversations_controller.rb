# frozen_string_literal: true

class ConversationsController < ApplicationController
  def new
    @conversation = Conversation.new
  end

  def create
    # create a new conversation from the params
    @conversation = Conversation.create(conversation_params)
    respond_to do |format|
      format.html { redirect_to conversation_path(@conversation) }
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
  end

  # This method actually talks to the open ai client
  def chat(prompt)
    open_ai_client = OpenAiClient.new
    open_ai_client.chat_completions(messages: prompt, stream: true) do |chunk|
      # Send the chunk to the front end over websockets
      ActionCable.server.broadcast("conversation_#{params[:id]}", chunk: chunk)
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:prompt, :persona1, :persona2, :persona3)
  end
end
