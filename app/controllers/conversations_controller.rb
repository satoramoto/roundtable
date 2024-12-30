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

  def generate
    @conversation = Conversation.find(params[:id])
  end

  private

  def conversation_params
    params.require(:conversation).permit(:prompt, :persona1, :persona2, :persona3)
  end
end
