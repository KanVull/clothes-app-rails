class Admin::ProductCategoriesController < Admin::BaseController
  before_action :set_product_category, only: %i[show edit update destroy]

  def index
    @title = "Admin - Product Categories"
    @product_categories = ProductCategory.all
  end

  def show
    @title = "Admin - Product Category: #{params[:id]}"
  end

  def new
    @title = "Admin - New Product Category"
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)

    if @product_category.save
      flash[:success] = "Product category was successfully created."
      redirect_to admin_product_categories_path
    else
      flash.now[:warning] = "Product category wasn't created!"
      render :new
    end
  end

  def edit
    @title = "Admin - Product Category: #{params[:id]}"
  end

  def update
    if @product_category.update(product_category_params)
      flash[:success] = "Product category was successfully updated."
      redirect_to admin_product_categories_path(@product_category)
    else
      flash.now[:warning] = "Product category wasn't updated!"
      render :edit
    end
  end

  def destroy
    @product_category.destroy
    flash[:success] = "Product category was successfully deleted."
    redirect_to admin_product_categories_path
  end

  private

  def product_category_params
    params.require(:product_category).permit(:name, :description)
  end

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end
end
