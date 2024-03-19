class AddOrderProducts < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    create_table :order_products do |t|
      t.bigint :order_id, null: false
      t.bigint :product_id, null: false
      t.integer :quantity, default: 0, null: false
      t.decimal :price_at_purchase, default: 0, null: false

      t.timestamps
    end

    add_foreign_key :order_products, :orders
    add_index :order_products, :order_id, algorithm: :concurrently
    add_foreign_key :order_products, :products
    add_index :order_products, :product_id, algorithm: :concurrently
  end
end
