ActiveAdmin.register Cart do
  permit_params :user_id

  index do
    selectable_column
    id_column
    column :user
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :created_at
      row :updated_at
    end

    panel "Cart Items" do
      table_for cart.cart_items do
        column :id
        column :music
        column :quantity
        column :price
        column :created_at
        column :updated_at
        column :actions do |cart_item|
          link_to "View", admin_cart_item_path(cart_item)
        end
      end
    end
  end

  form do |f|
    f.inputs "Cart Details" do
      f.input :user
    end
    f.actions
  end
end
