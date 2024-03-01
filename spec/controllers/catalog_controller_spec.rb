require 'rails_helper'

RSpec.describe CatalogController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @products" do
      products = create_list(:random_product, 4)
      get :index
      expect(assigns(:products)).to eq(products[0..2])
    end

    it "assigns @pagy" do
      get :index
      expect(assigns(:pagy)).to be_present
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "paginates products with 3 items per page" do
      products = create_list(:random_product, 4)
      get :index
      expect(assigns(:products).count).to eq(3)
    end
  end

  describe "GET #show" do
    let(:product_category) { create(:random_product_category) }
    let!(:products) { create_list(:random_product, 4, product_category: product_category) }

    before do
      get :show, params: { name: product_category.name }
    end

    it "returns a success response" do
      expect(response).to be_successful
    end

    it "assigns @products" do
      expect(assigns(:products)).to eq(products[0..2])
    end

    it "assigns @pagy" do
      expect(assigns(:pagy)).to be_present
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "paginates products with 3 items per page" do
      expect(assigns(:products).count).to eq(3)
    end
  end

  describe ""
end
