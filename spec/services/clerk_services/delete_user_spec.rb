require 'rails_helper'

RSpec.describe ClerkServices::DeleteUser, type: :service do
  context 'with valid clerk id' do
    before do
      user = User.create(clerk_id: 'user_29wBMCtzATuFJut8jO2VNTVekS4')
      @body = double('body')
      allow(@body).to receive(:[]).with(:data).and_return({id: 'user_29wBMCtzATuFJut8jO2VNTVekS4'})
    end

    it 'deletes a user' do
      expect {
        ClerkServices::DeleteUser.new(@body).call
      }.to change(User, :count).by(-1)
    end

    it 'returns true' do
      expect(ClerkServices::DeleteUser.new(@body).call).to eq(true)
    end
  end

  context 'user does not exist' do
    before do
      @body = double('body')
      allow(@body).to receive(:[]).with(:data).and_return({id: 'user_29wBMCtzATuFJut8jO2VNTVekS4'})
    end

    it 'deletes a user' do
      expect {
        ClerkServices::DeleteUser.new(@body).call
      }.to change(User, :count).by(0)
    end

    it 'returns true' do
      expect(ClerkServices::DeleteUser.new(@body).call).to eq(false)
    end
  end

  context 'with invalid clerk_id' do
    before do
      @body = double('body')
      allow(@body).to receive(:[]).with(:data).and_return({id: 'user_75kjhlkjg'})
    end

    it 'does not create a user' do
      expect {
        ClerkServices::DeleteUser.new(@body).call
      }.to change(User, :count).by(0)
    end

    it 'returns false' do
      expect(ClerkServices::DeleteUser.new(@body).call).to eq(false)
    end
  end
end
