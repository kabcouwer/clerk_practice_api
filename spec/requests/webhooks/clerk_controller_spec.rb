require 'rails_helper'
require 'svix'
require 'openssl'
require 'base64'

RSpec.describe 'Webhooks::ClerkController', type: :request do
  before :each do
    secret = Rails.application.credentials.svix[:secret].split("_").last
    id = "msg_2TlRhTARINIRlwNCr8Kr9bdQGTl"
    timestamp = Time.now.to_i
    @payload = File.read("spec/fixtures/webhooks/clerk_user_created.json")
    toSign = "#{id}.#{timestamp}.#{@payload}"
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"), Base64.decode64(secret), toSign)).strip

    @headers = {
        "svix-id" => id,
        "svix-signature" => "v1,#{signature}",
        "svix-timestamp" => timestamp,
        "Content-Type" => "application/json"
    }
  end

  context 'valid clerk webhook' do
    describe 'webhook base controller' do
      it 'creates an inbound webhook' do
        expect {
          post webhooks_clerk_path, params: @payload, headers: @headers
        }.to change(InboundWebhook, :count).by(1)
        expect(response).to be_successful

        inbound_webhook = InboundWebhook.last

        expect(inbound_webhook.status).to eq("pending")
        expect(inbound_webhook.body).to eq(@payload)
      end
    end

    describe 'POST /webhooks/clerk' do
      it 'returns a 200' do
        post webhooks_clerk_path, params: @payload, headers: @headers

        expect(response).to be_successful
      end
    end
  end


end
