RSpec.describe ProductCategory, type: :model do
  describe 'validations' do
    let(:product_category) { build_stubbed(:product_category) }

    it 'is valid with valid attributes' do
      expect(product_category).to be_valid
    end

    it 'is valid without a slug, slug set from name' do
      product_category.slug = nil
      expect(product_category).to be_valid
    end

    it 'is not valid without a slug' do
      product_category.name = nil
      expect(product_category).not_to be_valid
    end

    it 'is not valid with a duplicate slug' do
      existing_category = create(:product_category)
      product_category.name = existing_category.name
      expect(product_category).not_to be_valid
    end
  end

  describe ".with_published_products" do
    let!(:category1) { create(:product_category) }
    let!(:category2) { create(:product_category) }

    let!(:published_product) { create(:product, product_category: category1, published_at: Time.zone.now) }
    let!(:unpublished_product) { create(:product, product_category: category2, published_at: nil) }

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
