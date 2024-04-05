RSpec.describe Order, type: :model do
  describe "validations" do
    it "is valid with an email" do
      order = build(:order)
      expect(order).to be_valid
    end

    it "is invalid without an email" do
      order = build(:order, email: nil)
      expect(order).to be_invalid
    end
  end

  describe ".create_from_cart" do
    let(:product1) { build_stubbed(:product, price: 10) }
    let(:product2) { build_stubbed(:product, price: 20) }
    let(:item1) { build_stubbed(:cart_product, product: product1, quantity: 2) }
    let(:item2) { build_stubbed(:cart_product, product: product2, quantity: 3) }

    context "when cart has a user" do
      let(:user) { create(:user, email: "example@example.com") }
      let(:cart) { build_stubbed(:cart, user: user) }

      before do
        allow(cart).to receive(:items).and_return([ item1, item2 ])
      end

      it "creates a new order with items from the cart and user's email" do
        order = Order.create_from_cart(cart)
        order.save

        expect(order.items.length).to eq(cart.items.count)

        order.items.each do |item|
          cart_item = cart.items.find { |cart_item| cart_item.product_id == item.product_id }
          expect(item.quantity).to eq(cart_item.quantity)
          expect(item.price_at_purchase).to eq(cart_item.product.price)
        end

        expect(order.total_amount).to eq(cart.total_amount)
        expect(order.user_id).to eq(cart.user_id)
        expect(order.email).to eq(user.email)
      end
    end

    context "when cart does not have a user" do
      let(:cart) { build_stubbed(:cart, user: nil) }

      before do
        allow(cart).to receive(:items).and_return([ item1, item2 ])
      end

      it "creates a new order with items from the cart" do
        order = Order.create_from_cart(cart)

        expect(order.items.length).to eq(cart.items.count)

        order.items.each do |item|
          cart_item = cart.items.find { |cart_item| cart_item.product_id == item.product_id }
          expect(item.quantity).to eq(cart_item.quantity)
          expect(item.price_at_purchase).to eq(cart_item.product.price)
        end

        expect(order.total_amount).to eq(cart.total_amount)
        expect(order.user_id).to eq(cart.user_id)
        expect(order.email).to be_nil
      end
    end
  end
end
