class CreateProducts < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    create_table :products do |t|
      t.string :name, limit: 128, null: false
      t.decimal :price, precision: 7, scale: 2, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.text :description
      t.string :image
      t.datetime :published_at
      t.bigint :product_category_id, null: false

      t.timestamps
    end

    add_foreign_key :products, :product_categories
    add_index :products, :product_category_id, algorithm: :concurrently

    add_index :products, :name, unique: true, algorithm: :concurrently
  end
end
