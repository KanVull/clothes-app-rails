ActiveAdmin.register Product do
  # Specify which attributes of the model should be displayed in the index view
  index do
    selectable_column
    id_column
    column :name
    column :price
    column :created_at
    actions
  end

  # Specify the permitted parameters for the form
  permit_params :name, :price, :description
end
