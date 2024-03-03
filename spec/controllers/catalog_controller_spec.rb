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

    it "assigns @title" do
      get :index
      expect(assigns(:title)).to eq("Store - Catalog")
    end

    it "assigns @form_action_path" do
      get :index
      expect(assigns(:form_action_path)).to eq(catalog_index_path)
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

    it "filters products by query" do
      product1 = create(:random_product, name: "Product 1")
      product2 = create(:random_product, name: "Product 2")

      get :index, params: { query: "Product 1" }

      expect(assigns(:products)).to include(product1)
      expect(assigns(:products)).not_to include(product2)
    end

    it "filters products by price range" do
      product1 = create(:random_product, price: 10)
      product2 = create(:random_product, price: 20)

      get :index, params: { min_price: 15, max_price: 25 }

      expect(assigns(:products)).to include(product2)
      expect(assigns(:products)).not_to include(product1)
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

    it "assigns @title" do
      expect(assigns(:title)).to eq("Store - #{product_category.name}")
    end

    it "assigns @form_action_path" do
      expect(assigns(:form_action_path)).to eq(catalog_path(product_category.name))
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "paginates products with 3 items per page" do
      expect(assigns(:products).count).to eq(3)
    end
  end

  describe "GET #show" do
    let(:category) { create(:random_product_category) }

    it "filters products by query" do
      product1 = create(:random_product, product_category: category, name: "Product 1")
      product2 = create(:random_product, product_category: category, name: "Product 2")
      product_diff_cat = create(:random_product, name: "Product 11")

      get :show, params: { name: category.name, query: "Product 1" }

      expect(assigns(:products)).to include(product1)
      expect(assigns(:products)).not_to include(product2)
      expect(assigns(:products)).not_to include(product_diff_cat)
    end

    it "filters products by price range" do
      product1 = create(:random_product, product_category: category, price: 10)
      product2 = create(:random_product, product_category: category, price: 20)
      product_diff_cat = create(:random_product, price: 20)

      get :show, params: { name: category.name, min_price: 15, max_price: 25 }

      expect(assigns(:products)).to include(product2)
      expect(assigns(:products)).not_to include(product1)
      expect(assigns(:products)).not_to include(product_diff_cat)
    end
  end
end
