require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:role) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:role_id) }
  end
end
