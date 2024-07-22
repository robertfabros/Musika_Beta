ActiveAdmin.register Order do
  permit_params :user_id, :province_id, :total_price, :status

  index do
    selectable_column
    id_column
    column :user
    column :province
    column :total_price
    column :status
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :province
      row :total_price
      row :status
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :id
        column :music
        column :quantity
        column :price
        column :created_at
        column :updated_at
        column :actions do |order_item|
          link_to "View", admin_order_item_path(order_item)
        end
      end
    end
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :user
      f.input :province
      f.input :total_price
      f.input :status
    end
    f.actions
  end
end
