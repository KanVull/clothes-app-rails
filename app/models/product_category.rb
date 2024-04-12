class ProductCategory < ApplicationRecord
  has_ancestry
  has_many :products, dependent: :destroy

  before_validation :set_slug_from_name

  validates :slug, presence: true, uniqueness: true

  scope :with_published_products, -> { joins(:products).merge(Product.published).distinct }

  def ransackable_associations(auth_object = nil)
    Rails.logger.info("WITHIN RANSACK ASSOCIATION")
    super + %w[impressionable]
  end

  def set_parent(parent)
    # Do nothing if parent_id is already self.parent.id
    return if parent.parent_of?(self)

    if parent == self
      raise "Setting node's parent to itself is not allowed"
    end

    self.parent = parent
  end

  private

  def set_slug_from_name
    return if slug.present?

    base_slug = name&.parameterize.presence
    return unless base_slug

    similar_slugs_count = ProductCategory.where("slug LIKE ?", "#{base_slug}%").count
    self.slug = similar_slugs_count.positive? ? "#{base_slug}_#{similar_slugs_count}" : base_slug
  end
end
