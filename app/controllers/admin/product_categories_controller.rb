class Admin::ProductCategoriesController < Admin::BaseController
  before_action :set_product_category, only: %i[show edit update destroy]
  before_action :set_root_categories, only: %i[show new edit update]

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
    p = product_category_params
    if p[:parent_id].present?
      parent_category = ProductCategory.find(p[:parent_id])
      new_category = parent_category.children.build(name: p[:name], description: p[:description])
    else
      new_category = ProductCategory.new(p)
    end

    if new_category.save
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
    p = product_category_params
    @product_category.set_parent(ProductCategory.find(p[:parent_id])) if p[:parent_id].present?
    unless @product_category.update(p)
      raise "Product categoty wasn't updated!"
    end
    flash[:success] = "Product category was successfully updated."
    redirect_to admin_product_category_path(@product_category)
  rescue => e
    flash.now[:warning] = e
    render :edit
  end

  def destroy
    @product_category.destroy
    flash[:success] = "Product category was successfully deleted."
    redirect_to admin_product_categories_path
  end

  private

  def product_category_params
    params.require(:product_category).permit(:parent_id, :name, :description)
  end

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def set_root_categories
    @root_categories = ProductCategory.roots
  end
end
