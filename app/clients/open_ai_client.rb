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

  def chat_completions(messages:, stream: true, cache_prompt: true, samplers: "edkypmxt",
                       temperature: 0.8, dynatemp_range: 0, dynatemp_exponent: 1, top_k: 40, top_p: 0.95,
                       min_p: 0.05, typical_p: 1, xtc_probability: 0, xtc_threshold: 0.1, repeat_last_n: 64,
                       repeat_penalty: 1, presence_penalty: 0, frequency_penalty: 0, dry_multiplier: 0,
                       dry_base: 1.75, dry_allowed_length: 2, dry_penalty_last_n: -1, max_tokens: -1,
                       timings_per_token: false)
    # Dynamically generate the payload from method arguments
    payload = method(__method__).parameters.each_with_object({}) do |param, hash|
      key = param[1]
      hash[key] = binding.local_variable_get(key)
    end

    if stream
      # Stream response in chunks
      @connection.post("/v1/chat/completions") do |req|
        req.headers["Content-Type"] = "application/json"
        req.body = JSON.generate(payload)
        req.options.on_data = Proc.new do |chunk, _|
          puts "Streamed chunk: #{chunk.strip}" # Process each chunk
        end
      end
    else
      # Standard response
      response = @connection.post("/v1/chat/completions") do |req|
        req.headers["Content-Type"] = "application/json"
        req.body = JSON.generate(payload)
      end

      if response.success?
        JSON.parse(response.body) # Return parsed JSON response
      else
        raise "Error: #{response.status} - #{response.body}"
      end
    end
  end
end
