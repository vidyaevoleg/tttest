require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user model' do
    it 'has valid factory' do
      user = create(:user)
      expect(user.valid?).to eq(true)
    end
  end
end
