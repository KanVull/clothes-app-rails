class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @title = "Admin - Products"
    @products = Product.all
  end

  def show
    @title = "Admin - Product:#{params[:id]}"
  end

  def new
    @title = "Admin - New Product"
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "Product was successfully created."
      redirect_to admin_products_path
    else
      flash.now[:warning] = "Product wasn't created!"
      render :new
    end
  end

  def edit
    @title = "Admin - Product:#{params[:id]}"
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Product was successfully updated."
      redirect_to admin_product_path(@product)
    else
      flash.now[:warning] = "Product wasn't updated!"
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Product was successfully deleted."
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :price,
      :quantity,
      :image,
      :description,
      :product_category_id,
      :published_at
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
