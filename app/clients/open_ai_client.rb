# frozen_string_literal: true

# Generic client for OpenAI API
# There are many "drop in" replacements for Open AI so it makes sense to start here
require "faraday"
require "json"

class OpenAiClient
  BASE_URL = ENV.fetch("OPEN_AI_BACKEND") { "http://localhost:11434" }
  MODEL = ENV.fetch("OPEN_AI_MODEL_NAME") { "llama3.2" }
  AUTH_TOKEN = ENV["OPEN_AI_API_KEY"]

  def initialize(base_url: BASE_URL)
    @connection = Faraday.new(url: base_url) do |conn|
      conn.adapter Faraday.default_adapter
    end
  end

  def chat_completions(messages)
    # There's a lot of stuff happening here, it's easy to miss the details
    # The key parts of the payload are the messages and the temperature
    #
    # "messages" is an array of all the messages in the conversation so far
    # This is what allows the model to generate a response based on the context of the conversation
    #
    # The "temperature" controls the randomness of the response
    # Higher values like 0.8 will generate more creative responses, but lower values like 0.2 will be more predictable
    payload = { model: MODEL, messages: messages, temperature: 0.8, stream: true }

    # The response from the API is streamed in chunks
    # We yield each chunk to the caller so they can process it
    # This is how we can update the message model in real-time
    @connection.post("/v1/chat/completions") do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{AUTH_TOKEN}" if AUTH_TOKEN

      req.body = JSON.generate(payload)
      req.options.on_data = Proc.new do |chunk, _|
        Rails.logger.info("Received chunk: #{chunk}")
        last_chunk = JSON.parse(chunk[6..-1]) # remove "data: " prefix and parse JSON
        yield last_chunk
      rescue
        # If there's an error parsing the chunk, we just assume the stream is done
        # FIXME This could be better, but it's a simple way to handle the error
      end
    end
  end
end
