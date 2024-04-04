class CartsController < ApplicationController
  def show
  end

  def update
    product = Product.find(params[:product_id])

    current_cart.update_item_quantity(product.id, params[:quantity].to_i)
    redirect_back(fallback_location: request.referer)
  rescue => e
    flash[:error] = "#{e.message}"
    redirect_back(fallback_location: request.referer)
  end
end
