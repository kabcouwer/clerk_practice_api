require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it { should have_many(:assignments) }
    it { should have_many(:users).through(:assignments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name)}
  end
end
