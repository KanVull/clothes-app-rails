class CartsController < ApplicationController
  before_action :set_cart

  def show
  end

  def update
    product = Product.find(params[:product_id])
    @cart.update_item_quantity(product.id, params[:quantity].to_i)
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(session_key: session.id.to_s)
    Current.cart = @cart
  end
end
