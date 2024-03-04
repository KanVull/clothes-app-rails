class Admin::ProductsController < ApplicationController
  def index
    @title = "Admin - Products"
    @products = Product.all
    render "index"
  end

  def show
    @title = "Admin - Product:#{params[:id]}"
    @product = Product.find(params[:id])
  end

  def new
    @title = "Admin - New Product"
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.name != product_params[:name] && product_name_is_not_unique?(product_params[:name])
      render :new
      return
    end

    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      render :new, notice: 'Product wasn\'t created!'
    end
  end

  def edit
    @title = "Admin - Product:#{params[:id]}"
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
 
    if @product.name != product_params[:name] && product_name_is_not_unique?(product_params[:name])
      render :edit
      return
    end

    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
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

  def product_name_is_not_unique?(product_name)
    existing_product = Product.find_by(name: product_name)
    if existing_product.present?
      flash.now[:warning] = "A product with the name '#{existing_product.name}' already exists."
      return true
    end
    return false
  end
end
