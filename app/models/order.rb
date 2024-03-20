class Order < ApplicationRecord
  has_many :items, class_name: "OrderProduct", dependent: :destroy
  has_many :products, through: :items

  validates :email, presence: true

  def self.with_items
    includes(:items)
  end

  def self.create_from_cart(cart)
    order = new()
    cart.items.each do |item|
      order.items.build(
        product_id: item.product_id,
        quantity: item.quantity,
        price_at_purchase: item.product.price
      )
    end
    order.total_amount = cart.total_amount
    order
  end
end
