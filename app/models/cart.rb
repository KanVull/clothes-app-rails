class Cart < ApplicationRecord
  has_many :items, class_name: "CartProduct", dependent: :destroy
  has_many :products, through: :items

  validates :session_key, presence: true

  def self.with_items
    includes(:items)
  end

  def update_item_quantity(product_id, quantity)
    item = items.find_or_initialize_by(product_id: product_id)
    item.quantity = quantity
    if item.quantity <= 0
      if !item.destroy
        raise "Failed to destroy item: #{item.errors.full_messages.join(', ')}"
      end
    elsif !item.save
      raise "Failed to save item: #{item.errors.full_messages.join(', ')}"
    end
  end

  def total_amount
    items.sum { |item| item.product.price * item.quantity }
  end

  def has_item?(product_id)
    items.find_by(product_id: product_id).present?
  end

  def items_count
    items.count
  end
end
