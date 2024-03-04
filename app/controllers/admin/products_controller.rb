class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
    render "index"
  end

  def show
    # @product = Product.find(:id)
  end

  def new
    # Logic to create a new product instance
  end

  def create
    # Logic to save a new product
  end

  def edit
    # Logic to fetch and display a product for editing
  end

  def update
    # Logic to update a product
  end

  def destroy
    # Logic to delete a product
  end
end
