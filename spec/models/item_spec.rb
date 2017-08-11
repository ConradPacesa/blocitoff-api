require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  it { is_expected.to belong_to(:user) }

  describe 'attributes' do
    it 'has name and user attributes' do
      expect(item).to have_attributes(name: item.name, user: item.user)
    end
  end
end
