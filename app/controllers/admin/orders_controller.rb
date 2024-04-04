class Admin::OrdersController < Admin::BaseController
  def index
    @title = "Admin - Orders"
    if params[:user_id].present?
      @orders = User.find(params[:user_id]).orders
    else
      @orders = Order.all
    end
  end

  def show
    @title = "Admin - Order: #{params[:id]}"
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to admin_orders_path, notice: "Order was successfully deleted."
  end
end
