require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#published?' do
    context 'when product is published' do
      it 'returns true' do
        product = Product.create(published_at: 1.day.ago)
        expect(product.published?).to eq(true)
      end
    end

    context 'when product is not published' do
      it 'returns false' do
        product = Product.create(published_at: nil)
        expect(product.published?).to eq(false)
      end
    end

    context 'when product is scheduled to be published in the future' do
      it 'returns false' do
        product = Product.create(published_at: 1.day.from_now)
        expect(product.published?).to eq(false)
      end
    end
  end
end
