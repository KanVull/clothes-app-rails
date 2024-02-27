class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, limit: 128, null: false
      t.decimal :price, precision: 7, scale: 2, null: false
      t.integer :quantity, null: false, default: 0
      t.text :description
      t.string :image
      t.references :product_categories, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
