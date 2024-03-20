class OrdersController < ApplicationController
  def new
    @order = Order.new
    cart = Cart.find_by(session_key: session.id.to_s)
    @order.create_from_cart(cart)
  end

  def create
    @order = Order.new(order_params)
    cart = Cart.find_by(session_key: session.id.to_s)

    if cart
      @order.create_from_cart(cart)

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
