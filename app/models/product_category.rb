class ProductCategory < ApplicationRecord
  has_ancestry
  has_many :products, dependent: :destroy

  before_validation :set_slug_from_name

  validates :slug, presence: true, uniqueness: true
  validate :slug_must_be_parameterized

  scope :with_published_products, -> { joins(:products).merge(Product.published).distinct }

  def ransackable_associations(auth_object = nil)
    Rails.logger.info("WITHIN RANSACK ASSOCIATION")
    super + %w[impressionable]
  end

  def set_parent(parent)
    # Do nothing if parent_id is already self.parent.id
    return if parent.parent_of?(self)

    self.parent = parent
  end

  def has_published_products?
    return true if products.exists?(&:published?)

    children.each do |subcategory|
      return true if subcategory.has_published_products?
    end

    false
  end

  private

  def set_slug_from_name
    return if slug.present?

    base_slug = name&.parameterize.presence
    return unless base_slug

    similar_slugs_count = ProductCategory.where("slug LIKE ?", "#{base_slug}%").count
    self.slug = similar_slugs_count.positive? ? "#{base_slug}-#{similar_slugs_count}" : base_slug
  end

  def slug_parameterized?
    slug.present? && slug.parameterize == slug
  end

  def slug_must_be_parameterized
    errors.add(:slug, "must be parameterized") unless slug_parameterized?
  end
end
