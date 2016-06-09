require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'attributes' do
    it 'has name' do
      expect(build(:product, name: 'Product A')).to have_attributes(name: 'Product A')
    end

    it 'has price' do
      expect(build(:product, price: 100)).to have_attributes(price: 100)
    end
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
  end
end
