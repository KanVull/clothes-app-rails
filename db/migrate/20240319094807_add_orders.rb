class AddOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :email, null: false
      t.string :shipping_address
      t.string :status
      t.decimal :total_amount, precision: 15, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
