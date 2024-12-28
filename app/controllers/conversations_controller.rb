# frozen_string_literal: true

class ConversationsController < ApplicationController
  def index
  end

  def create
    # create a new conversation from the params
    @conversation = Conversation.create
    redirect_to conversations_path(@conversation)
  end

  def show
    @conversation = Conversation.find(params[:id])
  end
end
