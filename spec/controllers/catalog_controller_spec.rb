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
    let(:product_category) { create(:random_product_category) }
    let!(:product) { create(:random_product, product_category: product_category) }

    before do
      get :show, params: { name: product_category.name }
    end

    it "returns a success response" do
      expect(response).to be_successful
    end

    it "assigns @products" do
      expect(assigns(:products)).to eq([product])
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end
end