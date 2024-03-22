module Admin
  class ProductCategoriesController < BaseController
    def index
      @title = "Admin - Product Categories"
      @product_categories = ProductCategory.all
      render "index"
    end

    def show
      @title = "Admin - Product Category: #{params[:id]}"
      @product_category = ProductCategory.find(params[:id])
    end

    def new
      @title = "Admin - New Product Category"
      @product_category = ProductCategory.new
    end

    def create
      params = product_category_params
      params[:name] = params[:shown_name].parameterize
      @product_category = ProductCategory.new(params)
      if @product_category.save
        redirect_to admin_product_categories_path, notice: "Product category was successfully created."
      else
        flash.now[:warning] = "Product category wasn't created!"
        render :new
      end
    end

    def edit
      @title = "Admin - Product Category: #{params[:id]}"
      @product_category = ProductCategory.find(params[:id])
    end

    def update
      @product_category = ProductCategory.find(params[:id])

      params = product_category_params
      params[:name] = params[:shown_name].parameterize
      if @product_category.update(params)
        redirect_to admin_product_categories_path(@product_category), notice: "Product category was successfully updated."
      else
        flash.now[:warning] = "Product category wasn't updated!"
        render :edit
      end
    end

    def destroy
      @product_category = ProductCategory.find(params[:id])
      @product_category.destroy
      redirect_to admin_product_categories_path, notice: "Product category was successfully deleted."
    end

    private

    def product_category_params
      params.require(:product_category).permit(:shown_name, :description)
    end
  end
end
