class AddDefaultValueToImageInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :image, :string, default: "default.png"
  end
end
