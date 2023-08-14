require 'rails_helper'

RSpec.describe 'GET /api/v0/users/:id', type: :request do
  before :each do
    @user = create(:user)
  end

  context "user exists" do
    it 'returns a user' do
      get api_v0_user_path(@user.id)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(response.body).to include(@user.clerk_id)
    end
  end

  context "user does not exist" do
    it 'returns a 404' do
      get api_v0_user_path(0)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.content_type).to eq("application/json")
      expect(response.body).to include("Couldn't find User")
    end
  end
end
