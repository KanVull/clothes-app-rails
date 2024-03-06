class CreateProductCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :product_categories do |t|
      t.string :name, null: false
      t.string :shown_name, null: false
      t.text :description

      t.timestamps
    end
    add_index :product_categories, :name, unique: true
  end
end
