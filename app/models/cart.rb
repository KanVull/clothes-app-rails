class Cart < ApplicationRecord
  has_many :items, class_name: "CartProduct", dependent: :destroy
  has_many :products, through: :items

  validates :session_key, presence: true

  def self.with_items
    includes(:items)
  end

  def update_item_quantity(product_id, quantity)
    item = items.find_or_initialize_by(product_id: product_id)
    item.quantity += quantity.to_i
    if item.quantity <= 0 || quantity.to_i == 0
      item.destroy
    else
      item.save
    end
  end

  def total_amount
    items.sum { |item| item.product.price * item.quantity }
  end
end
