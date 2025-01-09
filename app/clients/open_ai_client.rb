# frozen_string_literal: true

# Generic client for OpenAI API
# There are many "drop in" replacements for Open AI so it makes sense to start here
require "faraday"
require "json"

class OpenAiClient
  BASE_URL = ENV.fetch("OPEN_AI_BACKEND") { "http://localhost:8080" }

  def initialize(base_url: BASE_URL)
    @connection = Faraday.new(url: base_url) do |conn|
      conn.adapter Faraday.default_adapter
    end
  end

  def chat_completions(messages:, stream: true)
    # TODO support more of the openai API completions options like temperature, max_tokens, etc.
    payload = { messages: messages, temperature: 0.8 }

    response = @connection.post("/v1/chat/completions") do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = JSON.generate(payload)

      # TODO actually use this
      # This is where we get that fancy effect of the bot typing
      if stream
        req.options.on_data = Proc.new do |chunk, _|
          # TODO broadcast this to the message stream
          puts "Streamed chunk: #{chunk.strip}" # Process each chunk
        end
      end
    end

    if response.success?
      JSON.parse(response.body) # Return parsed JSON response
    else
      raise "Error: #{response.status} - #{response.body}"
    end
  end
end
