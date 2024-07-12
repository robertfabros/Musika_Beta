ActiveAdmin.register User do
  permit_params :name, :email, :password, :role, :address, :province_id

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column :address
    column :province
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :role
  filter :province
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :role
      f.input :address
      f.input :province
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :role
      row :address
      row :province
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
