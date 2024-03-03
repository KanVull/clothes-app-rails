class ProductCategory < ApplicationRecord
  has_many :products

  scope :with_published_products, -> { joins(:products).merge(Product.published).distinct }
end
