module Webhooks
  class ClerkJob < ApplicationJob
    queue_as :default

    def perform(inbound_webhook)
      body = JSON.parse(inbound_webhook.body, symbolize_names: true)
      event = body[:type]
      case event
      when 'user.created'
        if ClerkServices::CreateUser.new(body).call
          inbound_webhook.update!(status: :processed)
        else
          inbound_webhook.update!(status: :failed)
        end
      else
        inbound_webhook.update!(status: :skipped)
      end
    end
  end
end
