require 'svix'

module Webhooks
  class ClerkController < BaseController
    def create
      record = InboundWebhook.create!(body: payload)
      Webhooks::ClerkJob.perform_later(record)
      head :ok
    end

    private

    def verify_event
      headers = request.headers
      wh = Svix::Webhook.new(Rails.application.credentials.svix[:secret])
      json = wh.verify(payload, headers)
    rescue => e
      render json: { error: e.message }, status: :bad_request
    end

    def payload
      @payload ||= request.body.read
    end
  end
end
