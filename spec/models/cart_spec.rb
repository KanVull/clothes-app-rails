require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "validations" do
    it "is valid with a session key" do
      cart = build(:cart)
      expect(cart).to be_valid
    end

    it "is invalid without a session key" do
      cart = build(:cart, session_key: nil)
      expect(cart).to be_invalid
    end
  end

  describe "total_amount" do
    it "calculates the total amount correctly" do
      product1 = create(:product, price: 10)
      product2 = create(:product, price: 20)

      cart = create(:cart)
      create(:cart_product, cart: cart, product: product1, quantity: 2)
      create(:cart_product, cart: cart, product: product2, quantity: 3)

      # (10 * 2) + (20 * 3) = 80
      expect(cart.total_amount).to eq(80)
    end
  end
end
