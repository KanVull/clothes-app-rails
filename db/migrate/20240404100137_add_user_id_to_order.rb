class AddUserIdToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :user_id, :bigint, null: true
    add_foreign_key :orders, :users
  end
end
