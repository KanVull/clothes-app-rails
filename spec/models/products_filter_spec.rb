require 'rails_helper'

RSpec.describe ProductsFilter, type: :model do
  describe "#filter" do
    let!(:category) { create(:random_product_category) }
    let(:product1) { create(:random_product, name: "Test Product 1", price: 50) }
    let(:product2) { create(:random_product, name: "Test Product 2", price: 150) }
    let(:product3) { create(:random_product, name: "Product 3", price: 200) }

    it "filters products by query" do
      filter = ProductsFilter.new(query: "Test")
      filtered_products = filter.filter(Product.all)
      expect(filtered_products).to include(product1, product2)
      expect(filtered_products).not_to include(product3)
    end

    it "filters products by min_price" do
      filter = ProductsFilter.new(min_price: 100)
      filtered_products = filter.filter(Product.all)
      expect(filtered_products).to include(product2, product3)
      expect(filtered_products).not_to include(product1)
    end

    it "filters products by max_price" do
      filter = ProductsFilter.new(max_price: 100)
      filtered_products = filter.filter(Product.all)
      expect(filtered_products).to include(product1)
      expect(filtered_products).not_to include(product2, product3)
    end

    it "filters products by query, min_price, and max_price" do
      filter = ProductsFilter.new(query: "Test", min_price: 100, max_price: 250)
      filtered_products = filter.filter(Product.all)
      expect(filtered_products).to include(product2)
      expect(filtered_products).not_to include(product1, product3)
    end
  end
end
