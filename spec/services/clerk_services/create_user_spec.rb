require 'rails_helper'

RSpec.describe ClerkServices::CreateUser, type: :service do
  context 'with valid clerk id' do
    before do
      @body = double('body')
      allow(@body).to receive(:[]).with(:data).and_return({id: 'user_29w83sxmDNGwOuEthce5gg56FcC'})
    end

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


  context 'with invalid clerk_id' do
    before do
      @body = double('body')
      allow(@body).to receive(:[]).with(:data).and_return({id: nil})
    end

    it 'does not create a user' do
      expect {
        ClerkServices::CreateUser.new(@body).call
      }.to change(User, :count).by(0)
    end

    it 'returns false' do
      expect(ClerkServices::CreateUser.new(@body).call).to eq(false)
    end
  end
end
