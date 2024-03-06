class AdminController < ApplicationController
  def dashboard
    @links = {
      "Products": [
        {
          name: "Products",
          link: admin_products_path
        },
        {
          name: "Product Categories",
          link: admin_product_categories_path
        }
      ],
      "Users": [
        {
          name: "Users (test) (link to products)",
          link: admin_products_path
        }
      ]
    }
    render "dashboard"
  end
end
