ActiveAdmin.register Product do
  index do
    selectable_column
    id_column
    column :name
    column :price
    column :quantity
    column :created_at
    actions
  end

  permit_params :name, :price, :quantity, :product_category_id
end
