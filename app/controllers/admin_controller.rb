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
      "Orders": [
        {
          name: "Carts",
          link: admin_carts_path
        },
        {
          name: "Orders",
          link: admin_orders_path
        }
      ]
    }
    render "dashboard"
  end
end
