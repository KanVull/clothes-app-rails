require 'rails_helper'

RSpec.describe CatalogController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @products" do
      products = create_list(:product, 8)
      get :index
      expect(assigns(:products)).to eq(products[0..5])
    end

    it "assigns @pagy" do
      get :index
      expect(assigns(:pagy)).to be_present
    end

    it "assigns @title" do
      get :index
      expect(assigns(:title)).to eq("Store - Catalog")
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "paginates products with 6 items per page" do
      products = create_list(:product, 7)
      get :index
      expect(assigns(:products).count).to eq(6)
    end

    it "filters products by query" do
      product1 = create(:product, name: "Product 1")
      product2 = create(:product, name: "Product 2")

      get :index, params: { product_filter: { query: "Product 1" } }

      expect(assigns(:products)).to include(product1)
      expect(assigns(:products)).not_to include(product2)
    end

    it "filters products by price range" do
      product1 = create(:product, price: 10)
      product2 = create(:product, price: 20)

      get :index, params: { product_filter: { min_price: 15, max_price: 25 } }

      expect(assigns(:products)).to include(product2)
      expect(assigns(:products)).not_to include(product1)
    end

    context "when category_slug is present and exists" do
      let(:filter_params) { { query: "test", min_price: 10, max_price: 100 } }
      let!(:existing_category) { create(:product_category) }

      before do
        get :index, params: { category_slug: existing_category.slug }
      end

      it "sets @title with category name" do
        expect(assigns(:title)).to eq("Store - #{existing_category.name}")
      end

      it "filters products with category_slug" do
        expect(assigns(:filter).category_slug).to eq(existing_category.slug)
      end

      it "merges category_slug into f_params" do
        expect(assigns(:f_params).to_h).to include(category_slug: existing_category.slug)
      end

      it "does not render a 404 page" do
        expect(response).not_to have_http_status(:not_found)
      end
    end

    context "when category_slug is present but does not exist" do
      before do
        get :index, params: { category_slug: "Nonexistent Category" }
      end

      it "renders a 404 page" do
        expect(response).to have_http_status(:not_found)
      end

      it "does not set @title" do
        expect(assigns(:title)).to be_nil
      end
    end

    context "when category_slug is not present" do
      it "sets @title to 'Store - Catalog'" do
        get :index
        expect(assigns(:title)).to eq("Store - Catalog")
      end

      it "does not filter products with category_slug" do
        get :index
        expect(assigns(:filter).category_slug).to be_nil
      end
    end
  end
end
