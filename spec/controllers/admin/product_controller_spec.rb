require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  describe "POST #create" do
    let!(:category) { create(:random_product_category) }
    let(:valid_params) do
      {
        product: {
          name: "Test Product",
          price: 10,
          quantity: 10,
          product_category_id: category.id
        }
      }
    end
    let(:invalid_params) { { product: { name: "Test Product 2", price: 10 } } }

    context "with valid params" do
      it "creates a new product" do
        expect {
          post :create, params: valid_params
        }.to change(Product, :count).by(1)
      end

      it "redirects to admin products index" do
        post :create, params: valid_params
        expect(response).to redirect_to(admin_products_path)
      end

      it "sets a flash notice" do
        post :create, params: valid_params
        expect(flash[:notice]).to eq("Product was successfully created.")
      end
    end

    context "with invalid params" do
      it "does not create a new product" do
        expect {
          post :create, params: invalid_params
        }.to_not change(Product, :count)
      end

      it "renders the new template" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end

      it "sets a flash warning" do
        post :create, params: invalid_params
        expect(flash.now[:warning]).to eq("Product wasn't created!")
      end
    end
  end

  describe "PATCH #update" do
    let!(:category) { create(:random_product_category) }
    let!(:category2) { create(:random_product_category) }
    let(:product) { create(:random_product, product_category: category) }

    context "with valid params" do
      let(:valid_params) do
        {
          name: "New Random Name",
          price: 20,
          quantity: 10,
          product_category_id: category2.id
        }
      end

      it "updates the product and redirects to admin product path with notice" do
        patch :update, params: { id: product.id, product: valid_params }
        expect(response).to redirect_to(admin_product_path(product))
        expect(flash[:notice]).to eq("Product was successfully updated.")
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          name: "",
          price: -1,
          quantity: -1,
          product_category_id: category2.id
        }
      end

      it "does not update the product and renders edit template with warning" do
        patch :update, params: { id: product.id, product: invalid_params }
        expect(response).to render_template(:edit)
        expect(flash.now[:warning]).to eq("Product wasn't updated!")
      end

      it "does not update the product with non-unique name and renders edit template" do
        duplicate_product = create(:random_product, name: "Duplicate Name")
        patch :update, params: { id: product.id, product: { name: "Duplicate Name" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:product) { create(:random_product) }

    it "destroys the product" do
      product1 = product
      expect {
        delete :destroy, params: { id: product1.id }
      }.to change(Product, :count).by(-1)
    end

    it "redirects to admin_products_path" do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(admin_products_path)
    end

    it "sets flash notice" do
      delete :destroy, params: { id: product.id }
      expect(flash[:notice]).to eq("Product was successfully deleted.")
    end
  end
end
