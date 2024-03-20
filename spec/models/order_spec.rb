require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it "is valid with a session key and email" do
      order = build(:order)
      expect(order).to be_valid
    end

    it "is invalid without a session key" do
      order = build(:order, session_key: nil)
      expect(order).to be_invalid
    end

    it "is invalid without an email" do
      order = build(:order, email: nil)
      expect(order).to be_invalid
    end
  end

  describe "#create_from_cart" do
    it "creates order and order products from cart" do
      cart = create(:cart)
      product1 = create(:product, price: 10)
      product2 = create(:product, price: 20)
      create(:cart_product, cart: cart, product: product1, quantity: 2)
      create(:cart_product, cart: cart, product: product2, quantity: 3)

      order = create(:order)
      order.create_from_cart(cart)
      order.save

      expect(order.session_key).to eq(cart.session_key)
      expect(order.email).to be_present
      expect(order.order_products.count).to eq(2)
      expect(order.total_amount).to eq(cart.total_amount)
    end
  end
end
