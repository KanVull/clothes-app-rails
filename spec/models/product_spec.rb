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
    describe '.published' do
      product_published = create(:random_product, published_at: 1.day.ago)
      product_unpublished = create(:random_product, published_at: nil)
      product_future_published = create(:random_product, published_at: 1.day.from_now)

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

    describe "min_price_gte scope" do
      it "filters products by minimum price" do
        product1 = create(:random_product, price: 100)
        product2 = create(:random_product, price: 200)

        expect(Product.min_price_gte(150)).to include(product2)
        expect(Product.min_price_gte(150)).not_to include(product1)
      end

      it "returns all products when minimum price is not provided" do
        product1 = create(:random_product, price: 100)
        product2 = create(:random_product, price: 200)

        expect(Product.min_price_gte(nil)).to include(product1, product2)
      end
    end

    describe "max_price_lte scope" do
      it "filters products by maximum price" do
        product1 = create(:random_product, price: 100)
        product2 = create(:random_product, price: 200)

        expect(Product.max_price_lte(150)).to include(product1)
        expect(Product.max_price_lte(150)).not_to include(product2)
      end

      it "returns all products when maximum price is not provided" do
        product1 = create(:random_product, price: 100)
        product2 = create(:random_product, price: 200)

        expect(Product.max_price_lte(nil)).to include(product1, product2)
      end
    end
  end
end
