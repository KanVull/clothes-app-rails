class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  validates :session_key, presence: true

  def self.with_cart_products
    includes(:cart_products)
  end

  def total_amount
    cart_products.sum { |cart_product| cart_product.product.price * cart_product.quantity }
  end
end
