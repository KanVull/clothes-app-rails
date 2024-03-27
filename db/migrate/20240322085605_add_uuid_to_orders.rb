class AddUuidToOrders < ActiveRecord::Migration[7.1]
  def up
    add_column :orders, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :orders, :uuid, unique: true
  end
end
