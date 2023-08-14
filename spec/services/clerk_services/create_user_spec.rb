require 'rails_helper'

RSpec.describe ClerkServices::CreateUser, type: :service do
  before :each do
    @payload = File.read("spec/fixtures/webhooks/clerk_user_created.json")
    @inbound_webhook = InboundWebhook.create(body: @payload)
    @body = JSON.parse(@inbound_webhook.body, symbolize_names: true)
  end

  context 'with valid body' do
    it 'creates a user' do
      expect {
        ClerkServices::CreateUser.new(@body).call
      }.to change(User, :count).by(1)

      user = User.last

      expect(user.id).to be_an(Integer)
      expect(user.clerk_id).to eq(@body[:data][:id])
    end

    it 'returns true' do
      expect(ClerkServices::CreateUser.new(@body).call).to eq(true)
    end
  end

  context 'with invalid body' do
    #can this be tested?
  end
end
