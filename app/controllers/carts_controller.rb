class CartsController < ApplicationController
  before_action :set_cart

  def show
  end

  def update
    product = Product.find(params[:product_id])
    cart_product = @cart.cart_products.find_or_initialize_by(product_id: product.id)

    cart_product.quantity += params[:quantity].to_i
    if cart_product.quantity <= 0 or params[:quantity].to_i == 0
      cart_product.destroy
    else
      cart_product.save
    end
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(session_key: session.id.to_s)
  end
end
