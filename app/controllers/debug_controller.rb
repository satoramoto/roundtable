# frozen_string_literal: true

class DebugController < ApplicationController
  def index
    render json: ::OpenAiClient.new.list_models
  end
end
