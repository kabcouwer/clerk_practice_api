require 'rails_helper'

RSpec.describe Student, type: :model do
  before :each do
    @user = create(:user)
    @student = create(:student, user: @user)
  end
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:user_id) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:dob) }
    it { should validate_presence_of(:grade) }
  end
end
