module Admin
  class ProductsController < BaseController
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

      if @product.save
        redirect_to admin_products_path, notice: "Product was successfully created."
      else
        flash.now[:warning] = "Product wasn't created!"
        render :new
      end
    end

    def edit
      @title = "Admin - Product:#{params[:id]}"
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:id])

      if @product.update(product_params)
        redirect_to admin_product_path(@product), notice: "Product was successfully updated."
      else
        flash.now[:warning] = "Product wasn't updated!"
        render :edit
      end
    end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path, notice: "Product was successfully deleted."
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
  end
end
