class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
end
