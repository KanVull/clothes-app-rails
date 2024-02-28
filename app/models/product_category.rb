class ProductCategory < ApplicationRecord
  has_many :products

  def self.with_published_products
    joins(:products).merge(Product.published).distinct
  end
end
