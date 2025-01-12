# frozen_string_literal: true

# Generic client for OpenAI API
# There are many "drop in" replacements for Open AI so it makes sense to start here
require "faraday"
require "json"

class OpenAiClient
  BASE_URL = ENV.fetch("OPEN_AI_BACKEND") { "http://localhost:11434" }

  def initialize(base_url: BASE_URL)
    @connection = Faraday.new(url: base_url) do |conn|
      conn.adapter Faraday.default_adapter
    end
  end

  def chat_completions(messages:, stream: true)
    payload = { model: "llama3.2", messages: messages, temperature: 0.8, stream: stream }

    last_chunk = nil
    response = @connection.post("/v1/chat/completions") do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = JSON.generate(payload)
      if stream
        req.options.on_data = Proc.new do |chunk, _|
          last_chunk = JSON.parse(chunk[6..-1]) # remove "data: " prefix and parse JSON
          yield last_chunk
        rescue
          # If we can't parse the chunk, assume this is the last one, don't yield
        end
      end
    end

    if response.success?
      if stream
        last_chunk
      else
        JSON.parse(response.body)
      end
    else
      raise "Error: #{response.status} - #{response.body}"
    end
  end
end
