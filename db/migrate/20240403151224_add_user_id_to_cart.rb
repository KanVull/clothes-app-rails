class AddUserIdToCart < ActiveRecord::Migration[7.1]
  def change
    change_column :carts, :session_key, :string, null: true
    add_column :carts, :user_id, :bigint, null: true
    add_foreign_key :carts, :users
  end
end
