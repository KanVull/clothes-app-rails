class Admin::HomeController < Admin::BaseController
  def index
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
      ],
      "Users": [
        {
          name: "Users",
          link: admin_users_path
        }
      ]
    }
  end
end
