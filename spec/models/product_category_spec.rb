RSpec.describe ProductCategory, type: :model do
    describe ".with_published_products" do
      let!(:category1) { create(:random_product_category) }
      let!(:category2) { create(:random_product_category) }
  
      let!(:published_product) { create(:random_product, product_category: category1, published_at: Time.zone.now) }
      let!(:unpublished_product) { create(:random_product, product_category: category2, published_at: nil) }
  
      it "returns product categories with published products" do
        categories_with_published_products = ProductCategory.with_published_products
        expect(categories_with_published_products).to include(category1)
        expect(categories_with_published_products).not_to include(category2)
      end
  
      it "returns an empty array if no categories have published products" do
        published_product.update(published_at: 1.day.from_now)
        categories_with_published_products = ProductCategory.with_published_products
        expect(categories_with_published_products).to be_empty
      end
    end
  end