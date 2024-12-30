# frozen_string_literal: true

# Generic client for OpenAI API
# There are many "drop in" replacements for Open AI so it makes sense to start here
class OpenAiClient
  include HTTParty

  base_uri "http://localhost:5001/v1"

  def chat_completions(model, messages, temperatures)
    self.class.post("/chat/completions", body: { model: model, messages: messages, temperatures: temperatures })
  end

  def edit_completions(model, instruction, input, temperature)
    self.class.post("/edit/completions", body: { model: model, instruction: instruction, input: input, temperature: temperature })
  end

  def completions(model, prompt, temperature)
    self.class.post("/completions", body: { model: model, prompt: prompt, temperature: temperature })
  end

  def list_models
    self.class.get("/models")
  end
end
