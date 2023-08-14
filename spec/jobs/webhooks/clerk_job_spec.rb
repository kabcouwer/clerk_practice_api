require 'rails_helper'

RSpec.describe Webhooks::ClerkJob, type: :job do
  context 'with valid inbound_webhook event type' do
    it 'processes the webhook and creates user' do
      payload = File.read('spec/fixtures/webhooks/clerk_user_created.json')
      inbound_webhook = InboundWebhook.create(body: payload)
      json = JSON.parse(inbound_webhook.body, symbolize_names: true)

      expect(inbound_webhook.status).to eq('pending')
      expect {
        Webhooks::ClerkJob.perform_now(inbound_webhook)
      }.to change(User, :count).by(1)
      expect(inbound_webhook.reload.status).to eq('processed')
    end
  end

  context 'with invalid inbound_webhook event type' do
    it 'skips the webhook and does not create user' do
      body = {
        data: 'data',
        object: 'event',
        type: 'test'
      }.to_json
      inbound_webhook = InboundWebhook.create(body: body)
      json = JSON.parse(inbound_webhook.body, symbolize_names: true)
      
      expect(inbound_webhook.status).to eq('pending')
      expect {
        Webhooks::ClerkJob.perform_now(inbound_webhook)
      }.to_not change(User, :count)
      expect(inbound_webhook.reload.status).to eq('skipped')
    end
  end
end
