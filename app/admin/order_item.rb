ActiveAdmin.register OrderItem do
  permit_params :order_id, :music_id, :quantity, :price

  index do
    selectable_column
    id_column
    column :order
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
      row :order
      row :music
      row :quantity
      row :price
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Order Item Details" do
      f.input :order
      f.input :music
      f.input :quantity
      f.input :price
    end
    f.actions
  end
end
