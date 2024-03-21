class OrdersController < ApplicationController
  def new
    if Current.cart.nil? || Current.cart.items.empty?
      redirect_to catalog_path, notice: "Your cart is empty. Please add items before placing an order."
    else
      @order = Order.create_from_cart(Current.cart)
    end
  end

  def create
    if Current.cart
      @order = Order.create_from_cart(Current.cart)
      @order.assign_attributes(order_params)

      if @order.save
        Current.cart.destroy
        redirect_to order_path(@order), notice: "Order placed successfully!"
        send_order(@order.email, order_url(@order))
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

  def send_order(email, link)
    OrderCreationMailer.send_order_link_to(email, link).deliver_now
  end

  def order_params
    params.require(:order).permit(:email)
  end
end
