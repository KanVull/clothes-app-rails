class RemoveDefaultValueImageFromUsersAndProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :image, :string, default: nil
    change_column :users, :image, :string, default: nil
  end
end
