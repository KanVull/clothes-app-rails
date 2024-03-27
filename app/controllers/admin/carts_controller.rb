class Admin::CartsController < Admin::BaseController
  def index
    @title = "Admin - Carts"
    @carts = Cart.all
  end

  def show
    @title = "Admin - Cart: #{params[:id]}"
    @cart = Cart.find(params[:id])
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to admin_carts_path, notice: "Cart was successfully deleted."
  end
end
