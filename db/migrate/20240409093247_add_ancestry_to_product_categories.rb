class AddAncestryToProductCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :product_categories, :ancestry, :string, null: false, default: "/"
    add_index :product_categories, :ancestry
  end
end
