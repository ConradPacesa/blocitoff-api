require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create{:user} }

  # it { is_expected.to validate_presence_of(:email) }
  # it { is_expected.to validate_presence_of(:password) }

  describe "attributes" do
    it 'should have name and email attributes' do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end
  end
end
