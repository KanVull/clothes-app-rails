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
      product_category.slug = existing_category.slug
      expect(product_category).not_to be_valid
    end

    it 'is valid with a duplicate name' do
      existing_category = create(:product_category)
      product_category.name = existing_category.name
      expect(product_category).to be_valid
    end
  end

  describe '#set_slug_from_name' do
    it 'ensures uniqueness of the slug' do
      category1 = create(:product_category, name: 'New Category', slug: nil)
      category2 = create(:product_category, name: 'New Category', slug: nil)
      category3 = create(:product_category, name: 'New Category', slug: nil)
      expect(category1.slug).to eq('new-category')
      expect(category2.slug).to eq('new-category-1')
      expect(category3.slug).to eq('new-category-2')
    end

    it 'does not change the slug if already present' do
      category = build(:product_category, name: 'New Category', slug: 'custom-slug')
      expect(category.slug).to eq('custom-slug')
    end
  end

  describe '#slug_must_be_parametrized' do
    it 'adds error if slug is not parametrized' do
      category = build(:product_category, slug: 'invalid slug')
      category.valid?
      expect(category.errors[:slug]).to include("must be parameterized")
    end

    it 'change slug to unparameterized value cause an error' do
      category = build(:product_category, name: 'Valid name')
      category.valid?
      expect(category).to be_valid
      category.slug = "Invalid slug"
      category.valid?
      expect(category.errors[:slug]).to include("must be parameterized")
    end
  end
end
