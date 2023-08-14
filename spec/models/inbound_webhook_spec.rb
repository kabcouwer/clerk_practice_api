require 'rails_helper'

RSpec.describe InboundWebhook, type: :model do
  describe 'validations' do
    it { should define_enum_for(:status).with_values([:pending, :processed, :skipped, :failed]) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:status) }
  end
end
