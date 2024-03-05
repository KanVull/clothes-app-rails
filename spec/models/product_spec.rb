require 'rails_helper'
require 'shared_examples/price_filters'
require 'shared_examples/required_fields'

RSpec.describe Product, type: :model do
  describe "validations" do
    let!(:category) { create(:random_product_category) }
    let!(:product) { create(:random_product, product_category: category) }
    subject { product }

    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it "is invalid with a price less than 0" do
      product.price = -5
      expect(product).not_to be_valid
    end

    it "is invalid with a quantity less than 0" do
      product.quantity = -1
      expect(product).not_to be_valid
    end

    it_behaves_like "required_fields", :name
    it_behaves_like "required_fields", :price
    it_behaves_like "required_fields", :quantity
    it_behaves_like "required_fields", :product_category_id
  end

  describe '#published?' do
    let(:product) { build(:random_product, published_at: nil) }

    context 'when product is published' do
      it 'returns true' do
        product.published_at = 1.day.ago
        expect(product.published?).to eq(true)
      end
    end

    context 'when product is not published' do
      it 'returns false' do
        product.published_at = nil
        expect(product.published?).to eq(false)
      end
    end

    context 'when product is scheduled to be published in the future' do
      it 'returns false' do
        product.published_at = 1.day.from_now
        expect(product.published?).to eq(false)
      end
    end
  end

  context 'scopes' do
    describe '.published' do
      let!(:product_published) { create(:random_product, published_at: 1.day.ago) }
      let!(:product_unpublished) { create(:random_product, published_at: nil) }
      let!(:product_future_published) { create(:random_product, published_at: 1.day.from_now) }

      it 'includes products with a published_at in the past' do
        expect(Product.published).to include(product_published)
      end

      it 'excludes products with a nil published_at' do
        expect(Product.published).not_to include(product_unpublished)
      end

      it 'excludes products with a published_at in the future' do
        expect(Product.published).not_to include(product_future_published)
      end
    end

    describe ".where_name_is_like" do
      let!(:product1) { create(:random_product, name: "Hoodie") }
      let!(:product2) { create(:random_product, name: "Pants") }

      it "filters products by name" do
        expect(Product.where_name_is_like("Hoodie")).to include(product1)
        expect(Product.where_name_is_like("Hoodie")).not_to include(product2)
      end

      it "returns all products when name is not provided" do
        expect(Product.where_name_is_like(nil)).to include(product1, product2)
      end
    end

    describe ".min_price_gte" do
      include_examples "price filter", :min_price_gte, 'min', 150
    end

    describe ".max_price_lte" do
      include_examples "price filter", :max_price_lte, 'max', 150
    end
  end
end
