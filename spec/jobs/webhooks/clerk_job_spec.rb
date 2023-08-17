require 'rails_helper'

RSpec.describe Webhooks::ClerkJob, type: :job do
  context 'with valid user.created event' do
    before do
      payload = File.read('spec/fixtures/webhooks/clerk_user_created.json')
      @inbound_webhook = InboundWebhook.create(body: payload)
    end

    it 'creates a user' do
      expect {
        Webhooks::ClerkJob.perform_now(@inbound_webhook)
      }.to change(User, :count).by(1)
    end

    it 'updates the status' do
      expect(@inbound_webhook.status).to eq('pending')

      Webhooks::ClerkJob.perform_now(@inbound_webhook)

      expect(@inbound_webhook.reload.status).to eq('processed')
    end
  end

  context 'with valid user.deleted event' do
    before do
      payload = File.read('spec/fixtures/webhooks/clerk_user_deleted.json')
      clerk_id = JSON.parse(payload, symbolize_names: true)[:data][:id]
      user = User.create(clerk_id:)
      @inbound_webhook = InboundWebhook.create(body: payload)
    end

    it 'deletes a user' do
      expect {
        Webhooks::ClerkJob.perform_now(@inbound_webhook)
      }.to change(User, :count).by(-1)
    end

    it 'updates the status' do
      expect(@inbound_webhook.status).to eq('pending')

      Webhooks::ClerkJob.perform_now(@inbound_webhook)

      expect(@inbound_webhook.reload.status).to eq('processed')
    end
  end

  context 'with invalid event' do
    before do
      payload = { event: 'user.event'}.to_json
      @inbound_webhook = InboundWebhook.create(body: payload)
    end

    it 'does not create user' do
      expect {
        Webhooks::ClerkJob.perform_now(@inbound_webhook)
      }.to_not change(User, :count)
    end

    it 'updates status to :skipped' do
      expect(@inbound_webhook.status).to eq('pending')

      Webhooks::ClerkJob.perform_now(@inbound_webhook)

      expect(@inbound_webhook.reload.status).to eq('skipped')
    end
  end

  context 'with false return value from service' do
    before do
      payload = {
        data: {
          id: nil
        },
        type: 'user.created'
      }.to_json
      @inbound_webhook = InboundWebhook.create(body: payload)
    end

    it 'does not create user' do
      expect {
        Webhooks::ClerkJob.perform_now(@inbound_webhook)
      }.to_not change(User, :count)
    end

    it 'updates status to :failed' do
      expect(@inbound_webhook.status).to eq('pending')

      Webhooks::ClerkJob.perform_now(@inbound_webhook)

      expect(@inbound_webhook.reload.status).to eq('skipped')
    end
  end
end
