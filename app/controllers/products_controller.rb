class ProductsController < BaseController
  def show
    @product = Product.find(params[:id])
  end
end
