ActiveAdmin.register CartItem do
  permit_params :cart_id, :music_id, :quantity, :price

  index do
    selectable_column
    id_column
    column :cart
    column :music
    column :quantity
    column :price
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :cart
      row :music
      row :quantity
      row :price
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Cart Item Details" do
      f.input :cart
      f.input :music
      f.input :quantity
      f.input :price
    end
    f.actions
  end
end
