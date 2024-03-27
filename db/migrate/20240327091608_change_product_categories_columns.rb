class ChangeProductCategoriesColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :product_categories, :name, :slug
    rename_column :product_categories, :shown_name, :name
  end
end
