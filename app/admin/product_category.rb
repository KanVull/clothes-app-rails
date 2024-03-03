ActiveAdmin.register ProductCategory do
    index do
      selectable_column
      id_column
      column :name
      actions
    end

    # Specify the permitted parameters for the form
    permit_params :name
  end
