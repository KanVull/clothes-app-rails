require 'rails_helper'

RSpec.describe CatalogController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @products" do
      product = create(:random_product)
      get :index
      expect(assigns(:products)).to eq([product])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product_category = create(:random_product_category)
      product = create(:random_product, product_category: random_product_category)
      get :show, params: { name: product_category.name }
      expect(response).to be_successful
    end

    it "assigns @products" do
      product_category = create(:random_product_category)
      product = create(:random_product, product_category: random_product_category)
      get :show, params: { name: product_category.name }
      expect(assigns(:products)).to eq([product])
    end

    it "renders the index template" do
      product_category = create(:random_product_category)
      get :show, params: { name: product_category.name }
      expect(response).to render_template("index")
    end
  end
end