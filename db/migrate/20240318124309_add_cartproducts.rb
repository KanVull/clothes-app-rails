class AddCartproducts < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    create_table :cart_products do |t|
      t.bigint :cart_id, null: false
      t.bigint :product_id, null: false
      t.integer :quantity, default: 0, null: false

      t.timestamps
    end

    add_foreign_key :cart_products, :carts
    add_index :cart_products, :cart_id, algorithm: :concurrently
    add_foreign_key :cart_products, :products
    add_index :cart_products, :product_id, algorithm: :concurrently
  end
end
