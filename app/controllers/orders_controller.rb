class OrdersController < ApplicationController
  def new
    if current_cart.nil? || current_cart.items.empty?
      redirect_to catalog_path, notice: "Your cart is empty. Please add items before placing an order."
    else
      @order = Order.create_from_cart(Current.cart)
    end
  end

  def create
    if current_cart.items.empty?
      redirect_to catalog_path, alert: "Cart is empty!"
      return
    end

    @order = Order.create_from_cart(current_cart)
    @order.assign_attributes(order_params)

    if @order.save
      current_cart.destroy
      OrdersMailer.order_created(@order).deliver_now
      redirect_to catalog_path, notice: "Order placed successfully! You can check your email for order information!"
    else
      render :new
    end
  end

  def show
    @order = Order.find_by!(uuid: params[:uuid])
    render layout: "order"
  end

  private

  def order_params
    params.require(:order).permit(:email)
  end
end
