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

  describe "#update_item_quantity" do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    it "creates a new item if not present" do
      expect {
        cart.update_item_quantity(product.id, 2)
      }.to change { CartProduct.count }.by(1)
    end

    it "updates the quantity of an existing item" do
      cart.update_item_quantity(product.id, 2)
      expect {
        cart.update_item_quantity(product.id, 3)
      }.to_not change { CartProduct.count }

      expect(cart.items.find_by(product_id: product.id).quantity).to eq(3)
    end

    it "destroys the item if quantity becomes zero" do
      cart.update_item_quantity(product.id, 2)
      expect {
        cart.update_item_quantity(product.id, 0)
      }.to change { CartProduct.count }.by(-1)

      expect(cart.items.find_by(product_id: product.id)).to be_nil
    end
  end

  describe "#total_amount" do
    let(:cart) { build_stubbed(:cart) }
    let(:product1) { build_stubbed(:product, price: 10) }
    let(:product2) { build_stubbed(:product, price: 20) }
    let(:item1) { build_stubbed(:cart_product, product: product1, quantity: 2) }
    let(:item2) { build_stubbed(:cart_product, product: product2, quantity: 3) }

    before do
      allow(cart).to receive(:items).and_return([ item1, item2 ])
    end

    it "calculates the total amount correctly" do
      allow(item1).to receive_message_chain(:product, :price).and_return(10)
      allow(item2).to receive_message_chain(:product, :price).and_return(20)

      expect(cart.total_amount).to eq(80)
    end
  end

  describe '#merge!' do
    let(:cart1) { create(:cart) }
    let(:cart2) { create(:cart) }
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }

    before do
      create(:cart_product, cart: cart1, product: product1, quantity: 2)
      create(:cart_product, cart: cart2, product: product1, quantity: 3)
      create(:cart_product, cart: cart2, product: product2, quantity: 1)
    end

    it 'should merge cart2 items into cart1' do
      cart1.merge!(cart2)
      expect(cart1.items.count).to eq(2)
      expect(cart1.items.find_by(product_id: product1.id).quantity).to eq(5)
      expect(cart1.items.find_by(product_id: product2.id)).to_not be_nil
    end

    it 'should update quantity of existing products' do
      cart1.merge!(cart2)
      cart1_item = cart1.items.find_by(product_id: product1.id)
      expect(cart1_item.quantity).to eq(5)
    end

    it 'should create new cart products for new products' do
      cart1.merge!(cart2)
      expect(cart1.items.where(product_id: product2.id)).to exist
    end

    it 'should destroy cart2' do
      expect { cart1.merge!(cart2) }.to change { Cart.exists?(cart2.id) }.from(true).to(false)
    end
  end
end
