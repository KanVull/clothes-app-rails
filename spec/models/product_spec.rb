require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#published?' do
    let(:product) { build(:random_product, published_at: nil) }

    context 'when product is published' do
      let(:published_time) { 1.day.ago }

      it 'returns true' do
        product.published_at = published_time
        expect(product.published?).to eq(true)
      end
    end

    context 'when product is not published' do
      let(:unpublished_time) { nil }

      it 'returns false' do
        product.published_at = unpublished_time
        expect(product.published?).to eq(false)
      end
    end

    context 'when product is scheduled to be published in the future' do
      let(:future_published_time) { 1.day.from_now }

      it 'returns false' do
        product.published_at = future_published_time
        expect(product.published?).to eq(false)
      end
    end
  end

  context 'scopes' do
    before do
      @product_published = create(:random_product, published_at: 1.day.ago)
      @product_unpublished = create(:random_product, published_at: nil)
      @product_future_published = create(:random_product, published_at: 1.day.from_now)
    end

    describe '.published' do
      it 'includes products with a published_at in the past' do
        expect(Product.published).to include(@product_published)
      end

      it 'excludes products with a nil published_at' do
        expect(Product.published).not_to include(@product_unpublished)
      end

      it 'excludes products with a published_at in the future' do
        expect(Product.published).not_to include(@product_future_published)
      end
    end
  end
end
