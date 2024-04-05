class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_amount
    quantity * price_at_purchase
  end
end
