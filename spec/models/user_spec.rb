require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:students) }
    it { should have_many(:assignments) }
    it { should have_many(:roles).through(:assignments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:clerk_id) }
    it { should validate_uniqueness_of(:clerk_id) }
  end
end
