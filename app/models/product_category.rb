class ProductCategory < ApplicationRecord
  has_ancestry
  has_many :products, dependent: :destroy

  before_validation :set_slug

  validates :slug, presence: true, uniqueness: true

  scope :with_published_products, -> { joins(:products).merge(Product.published).distinct }

  def ransackable_associations(auth_object = nil)
    Rails.logger.info("WITHIN RANSACK ASSOCIATION")
    super + %w[impressionable]
  end

  private

  def set_slug
    self.slug = name&.parameterize.presence
  end
end
