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
      @product_category = ProductCategory.new(product_category_params)

      if product_category_name_is_not_unique?(product_category_params[:name])
        render :new
        return
      end

      if @product_category.save
        redirect_to admin_products_category_path, notice: "Product category was successfully created."
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
      new_name = product_category_params[:name]
      if @product_category.name != new_name && product_category_name_is_not_unique?(new_name)
        render :edit
        return
      end

      if @product_category.update(product_category_params)
        redirect_to admin_product_category_path(@product_category), notice: "Product category was successfully updated."
      else
        flash.now[:warning] = "Product category wasn't updated!"
        render :edit
      end
    end

    def destroy
      @product_category = ProductCategory.find(params[:id])
      @product_category.destroy
      redirect_to admin_product_category_path, notice: "Product category was successfully deleted."
    end

    private

    def product_category_params
      params.require(:product_category).permit(
        :name,
        :shown_name,
        :description,
      )
    end

    def product_category_name_is_not_unique?(product_category_name)
      existing_product_category = ProductCategory.find_by(name: product_category_name)
      if existing_product_category.present?
        flash.now[:warning] = "A product category with the name '#{existing_product_category.name}' already exists."
        return true
      end
      false
    end
  end
end
