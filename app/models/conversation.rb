class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy

  # Set default values for the personas and prompt fields.
  before_create do |conversation|
    conversation.persona1 = "Albert Einstein" unless conversation.persona1.present?
    conversation.persona2 = "Nikola Tesla" unless conversation.persona2.present?
    conversation.persona3 = "Isaac Newton" unless conversation.persona3.present?
    conversation.prompt = "How can I save for retirement?" unless conversation.prompt.present?
  end
end
