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
      redirect_to admin_product_categories_path, notice: "Product category was successfully created."
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
      redirect_to admin_product_categories_path(@product_category), notice: "Product category was successfully updated."
    else
      flash.now[:warning] = "Product category wasn't updated!"
      render :edit
    end
  end

  def destroy
    @product_category.destroy
    redirect_to admin_product_categories_path, notice: "Product category was successfully deleted."
  end

  private

  def product_category_params
    params.require(:product_category).permit(:shown_name, :description)
  end

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end
end
