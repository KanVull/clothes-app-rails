class ProductImagesController < ApplicationController
  def destroy
    product = Product.find(params[:product_id])
    product.image.purge
    redirect_back fallback_location: request.referrer
  end
end
