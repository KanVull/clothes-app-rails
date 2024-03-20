class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :email, :session_key, presence: true

  def self.with_order_products
    includes(:order_products)
  end

  def create_from_cart(cart)
    self.session_key = cart.session_key
    cart.cart_products.each do |cart_p|
      order_products.build(
        product_id: cart_p.product_id,
        quantity: cart_p.quantity,
        price_at_purchase: cart_p.product.price
      )
    end
    self.total_amount = cart.total_amount
  end
end
