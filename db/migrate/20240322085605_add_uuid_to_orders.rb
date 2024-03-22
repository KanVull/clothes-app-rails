class AddUuidToOrders < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :order_products, column: :order_id

    add_column :orders, :uuid, :uuid, default: "gen_random_uuid()", null: false
    rename_column :orders, :id, :integer_id
    rename_column :orders, :uuid, :id
    execute "ALTER TABLE orders drop constraint orders_pkey;"
    execute "ALTER TABLE orders ADD PRIMARY KEY (id);"

    add_column :order_products, :uuid_order_id, :uuid
    remove_column :order_products, :order_id
    rename_column :order_products, :uuid_order_id, :order_id

    add_foreign_key :order_products, :orders, column: :order_id, primary_key: :id, on_delete: :cascade

    # delete incrementing
    execute "ALTER TABLE ONLY orders ALTER COLUMN integer_id DROP DEFAULT;"
    change_column_null :orders, :integer_id, true
    execute "DROP SEQUENCE IF EXISTS orders_id_seq"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
