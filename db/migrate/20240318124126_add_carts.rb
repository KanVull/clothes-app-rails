class AddCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.string :session_key, null: false

      t.timestamps
    end
  end
end
