module Webhooks
  class ClerkJob < ApplicationJob
    queue_as :default

    def perform(inbound_webhook)
      body = JSON.parse(inbound_webhook.body, symbolize_names: true)
      event = body[:type]

      case event
      when 'user.created'
        processed = ClerkServices::CreateUser.new(body).call
      when 'user.deleted'
        processed = ClerkServices::DeleteUser.new(body).call
      else
        processed = false
      end

      if processed
        inbound_webhook.update!(status: :processed)
      else
        inbound_webhook.update!(status: :skipped)
      end
    end
  end
end
