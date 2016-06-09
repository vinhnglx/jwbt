require 'rails_helper'

RSpec.describe User, type: :model do
  context 'attributes' do
    it 'has email' do
      expect(build(:user, email: "foo@bar.com")).to have_attributes(email: "foo@bar.com")
    end
  end

  context 'validations' do
    it { should validate_presence_of(:email) }
  end
end
