require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  it { is_expected.to belong_to(:user) }

  describe 'attributes' do
    it 'has name and user attributes' do
      expect(item).to have_attributes(name: item.name, user: item.user)
    end

    it 'has expires_at and completed attributes' do 
      expect(item).to have_attributes(expires_at: item.expires_at, completed: item.completed)
    end 
  end
end
