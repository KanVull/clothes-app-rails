class Cart < ApplicationRecord
  has_many :items, class_name: "CartProduct", dependent: :destroy
  has_many :products, through: :items
  belongs_to :user, optional: true

  validate :session_key_xor_user_id

  def self.with_items
    includes(:items)
  end

  def update_item_quantity(product_id, quantity)
    item = items.find_or_initialize_by(product_id: product_id)
    item.quantity = quantity
    if item.quantity.zero?
      item.destroy!
    else
      item.save!
    end
  end

  def total_amount
    items.sum { |item| item.product.price * item.quantity }
  end

  def has_item?(product_id)
    items.find_by(product_id: product_id).present?
  end

  def merge!(cart2)
    product_quantities = cart2.items.pluck(:product_id, :quantity).to_h
    existing_items = items.where(product_id: product_quantities.keys)

    existing_items.each do |existing_item|
      existing_item.update(quantity: existing_item.quantity + product_quantities[existing_item.product_id])
      product_quantities.delete(existing_item.product_id)
    end

    cart2.items.where(product_id: product_quantities.keys).update(cart_id: id)

    transaction do
      save!
      cart2.destroy!
    end
  end

  private

  def session_key_xor_user_id
    unless session_key.present? ^ user_id.present?
      errors.add :base, :invalid, message: "Either session key or user ID must be provided, but not both"
    end
  end
end
