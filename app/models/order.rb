class Order < ApplicationRecord
  has_many :items, class_name: "OrderProduct", dependent: :destroy
  has_many :products, through: :items
  belongs_to :user, optional: true

  before_validation :set_email
  validates :email, presence: true

  def self.with_items
    includes(:items)
  end

  def self.create_from_cart(cart)
    order = new(user: cart.user)

    cart.items.each do |item|
      order.items.build(
        product_id: item.product_id,
        quantity: item.quantity,
        price_at_purchase: item.product.price
      )
    end
    order.total_amount = cart.total_amount
    order.email = order.user&.email
    order
  end

  private

  def set_email
    if self.email.nil? && self.user.present?
      self.email = self.user.email
    end
  end
end
