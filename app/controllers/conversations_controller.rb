# frozen_string_literal: true

class ConversationsController < ApplicationController
  def new
    @conversation = Conversation.new
  end

  def create
    # create a new conversation from the params
    message = Message.new(content: conversation_params[:prompt], role: "user")
    conversation = Conversation.new(conversation_params.merge(messages: [message]))
    conversation.save!
    redirect_to conversation_path(conversation)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  private

  def conversation_params
    params.require(:conversation).permit(:prompt, :persona1, :persona2, :persona3)
  end
end
