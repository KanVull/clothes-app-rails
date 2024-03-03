class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :with_published_products, -> { joins(:products).merge(Product.published).distinct }

  def ransackable_associations(auth_object = nil)
    Rails.logger.info("WITHIN RANSACK ASSOCIATION")
    super + %w[impressionable]
  end
end
