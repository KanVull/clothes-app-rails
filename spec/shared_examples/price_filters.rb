RSpec.shared_examples "price filter" do |filter_method, comparator, price|
  let!(:product1) { create(:product, price: 100) }
  let!(:product2) { create(:product, price: 200) }

  it "filters products by #{comparator} price" do
    expect(Product.public_send(filter_method, price)).to include(comparator == 'min' ? product2 : product1)
    expect(Product.public_send(filter_method, price)).not_to include(comparator == 'min' ? product1 : product2)
  end

  it "returns all products when #{comparator} price is not provided" do
    expect(Product.public_send(filter_method, nil)).to include(product1, product2)
  end
end
