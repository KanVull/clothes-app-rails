class OrdersController < ApplicationController
  def new
    if current_cart.items.empty?
      redirect_to catalog_path, notice: "Your cart is empty. Please add items before placing an order."
    else
      @order = Order.create_from_cart(current_cart)
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
      if @order.user_id.present?
        redirect_to order_by_uuid_path(@order.uuid), notice: "Order placed successfully!"
      else
        redirect_to catalog_path, notice: "Order placed successfully! You can check your email for order information!"
      end
    else
      render :new
    end
  end

  def show
    @order = Order.find_by!(uuid: params[:uuid])
    unless @order.user
      render layout: "session_order"
    end
  end

  private

  def order_params
    params.require(:order).permit(:email, :shipping_address)
  end
end
