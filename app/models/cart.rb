class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  def self.with_cart_products
    includes(:cart_products)
  end
end
