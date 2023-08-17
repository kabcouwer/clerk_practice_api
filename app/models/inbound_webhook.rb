class InboundWebhook < ApplicationRecord
  enum status: { pending: 0, processed: 1, skipped: 2 }

  validates :body, presence: true
  validates :status, presence: true
end
