class OrdersController < ApplicationController
  def new
    cart = Cart.find_by(session_key: session.id.to_s)

    if cart.nil? || cart.items.empty?
      redirect_to catalog_path, notice: "Your cart is empty. Please add items before placing an order."
    else
      @order = Order.create_from_cart(cart)
    end
  end

  def create
    cart = Cart.find_by(session_key: session.id.to_s)

    if cart
      @order = Order.create_from_cart(cart)
      @order.assign_attributes(order_params)

      if @order.save
        cart.destroy
        redirect_to order_path(@order), notice: "Order placed successfully!"
      else
        render :new
      end
    else
      redirect_to root_path, alert: "Cart is empty!"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:email)
  end
end
