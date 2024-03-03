require 'rails_helper'
require 'shared_examples/price_filters'

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
    describe '.published' do
      before do
        @product_published = create(:random_product, published_at: 1.day.ago)
        @product_unpublished = create(:random_product, published_at: nil)
        @product_future_published = create(:random_product, published_at: 1.day.from_now)
      end

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

    describe "where_name_is_like scope" do
      it "filters products by name" do
        product1 = create(:random_product, name: "Apple iPhone")
        product2 = create(:random_product, name: "Samsung Galaxy")

        expect(Product.where_name_is_like("Apple")).to include(product1)
        expect(Product.where_name_is_like("Apple")).not_to include(product2)
      end

      it "returns all products when name is not provided" do
        product1 = create(:random_product, name: "Apple iPhone")
        product2 = create(:random_product, name: "Samsung Galaxy")

        expect(Product.where_name_is_like(nil)).to include(product1, product2)
      end
    end

    describe "min_price_gte" do
      include_examples "price filter", :min_price_gte, 'min', 150
    end

    describe "max_price_lte" do
      include_examples "price filter", :max_price_lte, 'max', 150
    end
  end
end
