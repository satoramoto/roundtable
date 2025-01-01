class Message < ApplicationRecord
  belongs_to :conversation

  validates :content, presence: true
  validates :role, presence: true

  # Implicitly order by created_at descending to show the newest messages first
  default_scope { order(created_at: :desc) }
end
